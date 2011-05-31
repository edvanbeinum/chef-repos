name "ciserver"
description "Continuous Integration Webserver"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
	"tomcat",
	"jenkins",
	"jenkins::tomcat",
	"jenkins::apache-tomcat",
	"jenkins::php-jenkins-template"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes()
# Attributes applied no matter what the node has set already.
override_attributes()