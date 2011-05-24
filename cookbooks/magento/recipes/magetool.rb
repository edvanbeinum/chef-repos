
include_recipe "php::zendframework"

include_recipe "php::pear"

mt = php_pear_channel "pear.magetool.co.uk" do
  action :discover
end

php_pear "magetool" do
  preferred_state "beta"
  channel mt.channel_name
  action :install
end

# This overwrites whatever was in .zf.ini beforehand, and also is
# hardcoded to the "user" user.  Is there any easy way to "push" onto
# the basicloader.classes array?

file "/home/vagrant/.zf.ini" do
  owner "vagrant"
  mode "0644"
  content [
    "php.include_path = \".:/usr/share/php:/usr/share/pear\"",
    "basicloader.classes.0 = \"MageTool_Tool_MageApp_Provider_Manifest\"",
    "basicloader.classes.1 = \"MageTool_Tool_MageExtension_Provider_Manifest\""
  ].join("\n")
end