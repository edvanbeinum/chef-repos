#
# Cookbook Name:: magento-base
# Recipe:: sample_data
#
# Copyright 2010, Ibuildings UK
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "magento-base::mysql"

unless File.exists?("#{node[:magento][:dir]}/app/etc/local.xml")

  remote_file "#{Chef::Config[:file_cache_path]}/magento-sample-data.tar.gz" do                       
    source node[:magento][:sample_data][:url]                                  
    mode "0644"                                                                
  end
  
  bash "magento-sample-data" do                                                
    cwd "#{Chef::Config[:file_cache_path]}"
    code <<-EOH
mkdir #{name}
cd #{name}
tar -zxvf  #{Chef::Config[:file_cache_path]}/magento-sample-data.tar.gz
mv magento-sample-data-* data
mv data/media/* #{node[:magento][:dir]}/media/
chmod -R o+w  #{node[:magento][:dir]}/media
mv data/magento_sample_data*.sql data.sql 2>/dev/null
/usr/bin/mysql -u #{node[:magento][:db][:username]} -p#{node[:magento][:db][:password]} #{node[:magento][:db][:database]} -v < data.sql
cd ..
rm -rf #{name}
EOH
  end
end

