#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute


bash "run_jenkins_on_tomcat" do
  user "root"
  cwd "/tmp"
  code <<-END 
  	cp /usr/share/jenkins/jenkins.war /var/lib/tomcat6/webapps/jenkins.war
  	chown tomcat6:tomcat6 /var/lib/tomcat6/webapps/jenkins.war
  	chmod a+x /var/lib/tomcat6/webapps/jenkins.war
END
end

if platform?(%w{debian ubuntu})
  execute "fix_debian_security" do      
    command "echo 'CATALINA_OPTS=\"-DJENKINS_HOME=/var/lib/tomcat6/webapps/jenkins/\"' >> /etc/default/tomcat6"  
    action :run
  end
end
