include_recipe "php::pear"

zf = php_pear_channel "pear.zfcampus.org" do
  action :discover
end

php_pear "zf" do
  channel zf.channel_name
  action :install
end