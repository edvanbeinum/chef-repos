name "apache-webhead"
description "Webserver running apache and php and MySql client"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "php", 
  "apache2",
  "apache2::mod_php5",
  "apache2::mod_rewrite",
  "apache2::mod_ssl",
  "apache2::mod_deflate",
  "apache2::mod_expires",
  "apache2::mod_headers",
  "mysql::client"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()