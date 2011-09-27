name "magento-application"
description "Magento Application server using Apache 2.x. This is the Admin interface with larger Memory usage. The cron tasks are configured to run on this machine, all large data processing happens here."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "php",
  "magento",
  "magento::install",
  "magento::config_local"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()