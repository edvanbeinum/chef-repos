#
# Cookbook Name:: ius
# Recipe:: default
#
# Copyright 2011, Alistair Stead
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

unless File.exists?("epel-release-1-1.ius.el5.noarch.rpm")

  bash "epel-release" do
    code <<-EOH
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/5.5/i386/epel-release-1-1.ius.el5.noarch.rpm
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/5.5/i386/ius-release-1.0-6.ius.el5.noarch.rpm
rpm -Uvh ius-release*.rpm epel-release*.rpm
EOH
  end
end

