name "magento-webhead"
description "Magento webhead server using Apache 2.x. This a streamlined and optimised version of Magento. Using less memory resource and tuned for customer performance"
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
  "apache2::mod_headers",
  "magento",
  "magento::self_signed_ssl",
  "magento::config_local"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes "apache" => {
    "prefork" => {
        "startservers" => 100,
        "minspareservers" => 100,
        "maxspareservers" => 150,
        "serverlimit" => 256,
        "maxclients" => 256,
        "maxrequestsperchild" => 4000
    },
    "worker" => {
        "startservers" => 100,
        "minspareservers" => 100,
        "maxspareservers" => 150,
        "serverlimit" => 256,
        "maxclients" => 256,
        "maxrequestsperchild" => 4000
    }
}
# Attributes applied no matter what the node has set already.
override_attributes()