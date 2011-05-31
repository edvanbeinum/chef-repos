include_recipe "git"
include_recipe "php::phpmd"
include_recipe "php::copypaste"
include_recipe "php::phploc"
include_recipe "php::documentor"
include_recipe "php::codesniffer"
include_recipe "php::codebrowser"
include_recipe "php::phpunit"


bash "get_source_code" do
  user "tomcat6"
  cwd "/tmp"
  code <<-END
    git clone https://magento-dreams.git
END
end
