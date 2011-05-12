# Installs (or upgrades to) a particular version of PHPUnit.  See
#
# http://www.phpunit.de/manual/current/en/installation.html

include_recipe "php::pear"

execute "pear_set_preferred_state" do
  command "pear config-set preferred_state beta"
  not_if "pear config-get preferred_state | grep beta"
end

execute "add_pear_phpunit_de_channel" do
 command "pear channel-discover pear.phpunit.de"
 not_if "pear list-channels | grep pear.phpunit.de"
end

execute "add_pear_symfony_project_com_channel" do
  command "pear channel-discover pear.symfony-project.com"
  not_if "pear list-channels | grep pear.symfony-project.com"
end      

execute "add_pear_components_ez_no_channel" do
  command "pear channel-discover components.ez.no"
  not_if "pear list-channels | grep components.ez.no"
end        

execute "add_php_codebrowser" do
  command "pear install --alldeps phpunit/PHP_CodeBrowser"
  not_if "phpunit --version | grep PHP_CodeBrowser"
end