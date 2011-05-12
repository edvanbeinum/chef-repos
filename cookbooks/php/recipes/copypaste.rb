include_recipe "php::pear"

execute "add_pear_phpunit_de_channel" do
 command "pear channel-discover pear.phpunit.de"
 not_if "pear list-channels | grep pear.phpunit.de"
end

execute "add_pear_phpcpd_channel" do
 command "pear channel-discover components.ez.no"
 not_if "pear list-channels | grep components.ez.no"
end

execute "install_phpcpd" do
  command "pear install --alldeps phpunit/phpcpd"
  not_if "pear list -a | grep phpcpd"
end