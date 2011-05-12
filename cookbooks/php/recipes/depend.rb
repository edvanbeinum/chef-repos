# Installs the latest version of PHPMD

include_recipe "php::pear"

execute "add_pear_pdepend_org_channel" do
 command "pear channel-discover pear.pdepend.org"
 not_if "pear list-channels | grep pear.pdepend.org"
end     

execute "add_php_depend" do
  command "pear install --alldeps pdepend/PHP_Depend-beta"
  not_if "pear list -a | grep PHP_Depend"
end
