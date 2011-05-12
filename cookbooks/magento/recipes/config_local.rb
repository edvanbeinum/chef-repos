template "#{node[:magento][:dir]}/app/etc/local.xml" do
  source "local.xml.erb"
end