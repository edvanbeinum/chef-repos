#
# Cookbook Name:: apache2
# Recipe:: mod_jk 
#
# Copyright 2008-2009, Opscode, Inc.
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

# http://blog.mansonthomas.com/2009/06/setup-tomcat6-with-native-library-with.html
# 
if platform?(%w{"centos"})
  bash "install_mod_jk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
      wget http://dev.centos.org/centos/5/testing/i386/RPMS/mod_jk-ap20-1.2.28-2.el5.centos.i386.rpm
      rpm -ivh  mod_jk-ap20-1.2.28-2.el5.centos.i386.rpm
EOH
  end
elsif platform?("redhat")
  bash "install_mod_jk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
      get http://mirrors.dotsrc.org/jpackage/1.7/redhat-el-5.0/free/RPMS/mod_jk-ap20-1.2.26-1jpp.i386.rpm
      rpm -ivh mod_jk-ap20-1.2.26-1jpp.i386.rpm
EOH
  end
end

package "libapache2-mod-jk" do
  case node[:platform]
    when "centos"
      package_name "mod_jk-ap20-1.2.28-2.el5.centos.i386.rpm"
    when "redhat"
      package_name "mod_jk-ap20-1.2.26-1jpp.i386.rpm"
    when "debian","ubuntu"
      package_name "libapache2-mod-jk"
  end
  action :install
end

# configure mod_jk, add jk.conf
template "/etc/apache2/mods-enabled/jk.conf" do
  source "mods/jk.conf.erb"
  owner "root"
  group "root"
end

# add /etc/apache2/worker.properties
template "/etc/apache2/workers.properties" do
  source "mods/jk-worker.properties.erb"
  owner "root"
  group "root"
end

service "apache2" do
  action :restart
end
