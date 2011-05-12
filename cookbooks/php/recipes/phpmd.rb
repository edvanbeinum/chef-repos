# Installs the latest version of PHPMD

include_recipe "php::pear"

execute "add_pear_phpmd_org_channel" do
 command "pear channel-discover pear.phpmd.org"
 not_if "pear list-channels | grep pear.phpmd.org"
end

execute "add_pear_pdepend_org_channel" do
  command "pear channel-discover pear.pdepend.org"
  not_if "pear list-channels | grep pear.pdepend.org"
end      

execute "add_phpmd" do
  command "pear install --alldeps phpmd/PHP_PMD-alpha"
  not_if "phpmd --version | grep PHPMD"
end
