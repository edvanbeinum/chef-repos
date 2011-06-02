include_recipe "php::depend"
include_recipe "php::phpmd"
include_recipe "php::copypaste"
include_recipe "php::phploc"
include_recipe "php::documentor"
include_recipe "php::codesniffer"
include_recipe "php::codebrowser"
include_recipe "php::phpunit"

cookbook_file "/tmp/jenkins-cli.jar" do
  source "jenkins-cli.jar"
  mode 0755
  action :create
end

ruby_block "wait_for_server_to_be_available" do
  block do
    sleep 30
  end
  action :create
end

modules = [
  "git",
  "github",
  "greenballs",
  "checkstyle",
  "clover",
  "dry",
  "htmlpublisher",
  "jdepend",
  "plot",
  "pmd",
  "violations",
  "xunit",
  "ci-game"
]

modules.each do
  |mod|
  bash "install_#{mod}" do
    user "root"
    cwd "/tmp"
    code "java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/#{mod}.hpi"
  end
end

cookbook_file "/var/lib/tomcat6/webapps/jenkins/jobs/php-template/config.xml" do
  source "config.xml"
  mode "0644"
end

# bash "get_php-jenkins-template" do
#   user "root"
#   cwd "/tmp"
#   code <<-END
#   wget --no-check-certificate https://github.com/sebastianbergmann/php-jenkins-template/tarball/master -O - | tar zx 
#   mv sebastianbergmann-php-jenkins-template-* /var/lib/tomcat6/webapps/jenkins/jobs/php-template
#   rm -r sebastianbergmann-php-jenkins-template-*
#   chown -R tomcat6:tomcat6 /var/lib/tomcat6/webapps/jenkins/jobs/php-template
# END
# end

bash "reload_jenkins" do
  user "root"
  cwd "/tmp"
  code "java -jar jenkins-cli.jar -s http://localhost:8080/ reload-configuration"
end
