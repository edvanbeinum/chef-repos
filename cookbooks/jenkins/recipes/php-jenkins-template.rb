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
  action :create
end

modules = [
  "checkstyle",
  "clover",
  "dry",
  "htmlpublisher",
  "jdepend",
  "plot",
  "pmd",
  "violations",
  "xunit"
]

modules.each do
  |mod|
  bash "install_jenkins_#{mod}" do
    user "root"
    cwd "/tmp"
    code "java -jar jenkins-cli.jar -s http://localhost:8080/jenkins install-plugin http://updates.jenkins-ci.org/latest/#{mod}.hpi"
  end
end

bash "get_php-jenkins-template" do
  user "root"
  cwd "/tmp"
  code <<-END
  wget --no-check-certificate https://github.com/sebastianbergmann/php-jenkins-template/tarball/master -O - | tar zx 
  mv sebastianbergmann-php-jenkins-template-* /var/lib/tomcat6/webapps/jenkins/jobs/php-template
  rm -r sebastianbergmann-php-jenkins-template-*
  chown -R tomcat6:tomcat6 /var/lib/tomcat6/webapps/jenkins/jobs/php-template
END
end

bash "reload_jenkins" do
  user "root"
  cwd "/tmp"
  code "java -jar jenkins-cli.jar -s http://localhost:8080/jenkins reload-configuration"
end
