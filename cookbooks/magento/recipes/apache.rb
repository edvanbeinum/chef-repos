web_app node[:magento][:apache][:servername] do
  template "apache-vhost.conf.erb"
  notifies :reload, resources("service[apache2]"), :delayed
end