#
# Cookbook Name:: magento-base
# Recipe:: php
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

include_recipe "php"
include_recipe "php::module_mcrypt"

# Mostly to extend memory_limit which 32Mb on Debian
# cookbook_file "/etc/php5/cli/php.ini" do
#   source "cli-php.ini"
#   mode 0644
#   owner "root"
#   group "root"
# end