pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-mcrypt"}, "default" => "php5-mcrypt")

if pack
  package pack do
    action :upgrade
  end
end

cookbook_file "/etc/php5/conf.d/mcrypt.ini" do
  mode "0644"
  source "mcrypt.ini"
  notifies :reload, resources("service[apache2]"), :delayed
end