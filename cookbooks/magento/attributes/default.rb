# General settings

default[:magento][:version] = "stable"
default[:magento][:downloader][:url] = "http://www.magentocommerce.com/downloads/assets/1.5.1.1/magento-1.5.1.1.tar.gz "
default[:magento][:dir] = "/var/www/magento"

default[:magento][:app][:locale] = "en_GB"
default[:magento][:app][:timezone] = "Europe/London"
default[:magento][:app][:currency] = "GBP"
default[:magento][:app][:session_save] = "db" # files|db|memcache
default[:magento][:app][:admin_frontname] = "admin"
default[:magento][:app][:use_rewrites] = "yes"
default[:magento][:app][:use_secure] = "no"
default[:magento][:app][:use_secure_admin] = "no"
default[:magento][:app][:multi_session_save] = "db" # files|db|memcache
default[:magento][:app][:backend_cache] = "file" # apc|memcached|xcache|file
default[:magento][:app][:backend_servers] = Array.new

default[:magento][:apache][:servername] = "magento.development.local"
default[:magento][:apache][:server_alias] = Array.new
default[:magento][:apache][:docroot] = "/var/www"
default[:magento][:apache][:path] = "/public"

default[:magento][:db][:host] = "localhost"
default[:magento][:db][:database] = "magentodb"
default[:magento][:db][:username] = "magentouser"


default[:magento][:admin][:firstname] = "Admin"
default[:magento][:admin][:lastname] = "Admin"
default[:magento][:admin][:email] = "support@magento.com"
default[:magento][:admin][:user] = "devadmin"

default[:magento][:sample_data][:url] = "http://www.magentocommerce.com/downloads/assets/1.2.0/magento-sample-data-1.2.0.tar.gz"

default[:magento][:server][:aliases] = Array.new
default[:magento][:server][:static_domains] = Array.new

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default_unless[:magento][:db][:password] = secure_password
default[:magento][:admin][:password] = 'pa33word'