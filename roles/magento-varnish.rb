name "magento-varnish"
description "Magento Varnish server listening on port 80 configured with multiple backend servers"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "magento::varnish"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()