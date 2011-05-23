# Installs the latest version of PHPMD

include_recipe "php::pear"

pd = php_pear_channel "pear.pdepend.org" do
  action :discover
end

php_pear "PHP_Depend" do
  # preferred_state "beta"
  channel pd.channel_name
  action :install
end
