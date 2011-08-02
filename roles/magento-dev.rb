name "magento-dev"
description "Specific project setup for the WMI Magento project"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
    "apt",
    # "ant", 
    # "git",
    "php",
    "php::pear",
    # "php::codebrowser",
    # "php::codesniffer",
    # "php::copypaste",
    # "php::depend",
    # "php::documentor",
    # "php::phpmd",
    # "php::phpunit",
    "php::xdebug",
    "magento::magetool",
    "memcached", 
    "apache2",
    "apache2::mod_php5",
    "apache2::mod_rewrite",
    "apache2::mod_ssl",
    "mysql::server",
    "magento",
    "magento::sample_data",
    "magento::memcached",
    "magento::install",
    "magento::config_local",
    "magento::varnish"
)
# Attributes applied if the node doesn't have it set already.
default_attributes(
  "apache" => {
    "contact" => "alistair@ibuildings.com",
    "listen_ports" => ["8080", "443"],
    "servertokens" => 'Dev'
  },
  "magento" => {
    "dir" => "/mnt/Sites/magento.development.local/public",
    "db" => {
      "database" => "magento_ce_db",
      "username" => "magento_ce_dbu",
      "password" => "magento_ce_dbpass"
    },
    "apache" => {
        "servername" => "magento.development.local",
        "server_alias" => [
              "magento.css.development.local",
              "magento.imgs.development.local",
              "magento.js.development.local"
          ],
          "docroot" => "/mnt/Sites",
          "path" => "/public"
      },
    "admin" => {
        "user" => 'devadmin',
        "password" => 'password123'
    },
    "app" => {
        "multi_session_save" => "memcache",
        "backend_cache" => "memcached",
        "backend_servers" => [
        {
          "host" => "127.0.0.1",
          "port" => "11211",
          "persistent" => "1",
          "weight" => "1",
          "timeout" => "10",
          "retry_interval" => "10",
          "status" => "1"
        }
      ]
    }
  }
)
# Attributes applied no matter what the node has set already.
override_attributes(
  "apache" => {
    "listen_ports" => ["8080", "443"]
  },
  "mysql" => {
    "server_root_password" => "root",
    "bind_address" => "127.0.0.1"
  },
  "memcached" => {
    "memory" => "128",
    "user" => "www-data",
    "port" => "11211",
    "listen" => "127.0.0.1"
  },
  "magento" => {
      "admin" => {
          "user" => 'devadmin',
          "password" => 'password123'
      }
    }
)