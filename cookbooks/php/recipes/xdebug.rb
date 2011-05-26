
# Needed for phpize, which pecl needs
include_recipe "php::module_dev"

php_pear "xdebug" do
  action :install
end

# execute "install_xdebug" do
#   command "pecl install xdebug"
#   not_if "pecl list | grep xdebug"
#   notifies :reload, resources(:service => "apache2"), :delayed
# end
# 
# template "/etc/php5/conf.d/xdebug.ini" do
#   mode "0644"
#   source "xdebug.ini.erb"
#   notifies :reload, resources(:service => "apache2"), :delayed
# end

