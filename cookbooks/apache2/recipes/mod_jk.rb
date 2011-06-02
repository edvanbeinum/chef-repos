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
  bash "install_centos_mod_jk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
      wget http://dev.centos.org/centos/5/testing/i386/RPMS/mod_jk-ap20-1.2.28-2.el5.centos.i386.rpm
      rpm -ivh  mod_jk-ap20-1.2.28-2.el5.centos.i386.rpm | cat
EOH
  end
elsif platform?("redhat")
  bash "install_redhat_mod_jk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
      wget http://mirrors.dotsrc.org/jpackage/1.7/redhat-el-5.0/free/RPMS/mod_jk-ap20-1.2.26-1jpp.i386.rpm
      rpm -ivh mod_jk-ap20-1.2.26-1jpp.i386.rpm | cat
EOH
  end
end

pkgs = value_for_platform(
  ["centos", "redhat", "fedora"] => {"default" => %w{"mod_jk-ap20"}},
  ["ubuntu", "debian"] => {"default" => %w{"libapache2-mod-jk"}},
  "default" => %w{"libapache2-mod-jk"}
)

pkgs.each do |pkg|
  package pkg do
    action :upgrade
  end
end

# configure mod_jk, add jk.conf
template "#{node[:apache][:dir]}/mods-available/jk.conf" do
  source "mods/jk.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

# add /etc/apache2/worker.properties
template "#{node[:apache][:dir]}/workers.properties" do
  source "mods/jk-worker.properties.erb"
  owner "root"
  group "root"
end

apache_module "jk" do
  conf true
end

service "apache2" do
  action :restart
end
