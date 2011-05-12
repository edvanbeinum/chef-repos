include_recipe "php::pear"

execute "install_phpcs" do
  command "pear install --alldeps PHP_CodeSniffer"
  not_if "pear list -a | grep PHP_CodeSniffer"
end