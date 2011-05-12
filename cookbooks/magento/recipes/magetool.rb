execute "add_pear_magetool_co_uk_channel" do
 command "pear channel-discover pear.magetool.co.uk"
 not_if "pear list-channels | grep pear.magetool.co.uk"
end

execute "add_magetool" do
  command "pear install magetool/magetool"
  not_if "pear list -c pear.magetool.co.uk | grep MageTool"
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