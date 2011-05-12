web_app node[:apache][:servername] do
  template "apache-vhost.conf.erb"
  notifies :reload, resources("service[apache2]"), :delayed
end