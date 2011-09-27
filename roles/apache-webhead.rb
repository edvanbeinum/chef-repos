name "apache-webhead"
description "Webserver running Apache 2.x and php 5.3.x and mySQL client. This has no specific application
configuration and can be used in conjunction with the specific application role."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "mysql::client",
  "php", 
  "apache2",
  "apache2::mod_php5",
  "apache2::mod_rewrite",
  "apache2::mod_ssl",
  "apache2::mod_deflate",
  "apache2::mod_expires",
  "apache2::mod_headers"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()