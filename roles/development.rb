name "development"
description "PHP Development system"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "php",
  "php::pear",
  # "php::codebrowser",
  "php::codesniffer",
  "php::copypaste",
  # "php::depend",
  "php::documentor",
  "php::phpmd",
  "php::phpunit",
  "php::xdebug",
  "magento::magetool"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()