execute "add_pear_zfcampus_org_channel" do
 command "pear channel-discover pear.zfcampus.org"
 not_if "pear list-channels | grep pear.zfcampus.org"
end

execute "add_zendframework" do
  command "pear install --alldeps zfcampus/zf"
  not_if "zf | grep Zend"
end