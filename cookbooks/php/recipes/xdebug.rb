# Needed for phpize, which pecl needs
package "php5-dev"

execute "install_xdebug" do
  command "pecl install xdebug"
  not_if "pecl list | grep xdebug"
  notifies :reload, resources("service[apache2]"), :delayed
end

template "/etc/php5/conf.d/xdebug.ini" do
  mode "0644"
  source "xdebug.ini.erb"
  notifies :reload, resources("service[apache2]"), :delayed
end

