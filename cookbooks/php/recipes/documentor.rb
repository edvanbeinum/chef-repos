include_recipe "php::pear"

execute "install_PhpDocumentor" do
  command "pear install --alldeps PhpDocumentor"
  not_if "pear list -a | grep PhpDocumentor"
end