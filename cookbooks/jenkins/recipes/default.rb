#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#     wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
# sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
# sudo aptitude update
# sudo aptitude install jenkins


packages = value_for_platform(
  ["centos", "redhat", "fedora", "suse"] => {"default" => %w(ant daemon)},
  "default" => %w{ant daemon}
)

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

bash "install_jenkins" do
user "root"
  cwd "/tmp"
  if platform?(%w{debian ubuntu})
	code <<-EOH
	    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	    sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
	    apt-get update	    
	  EOH
  elsif plaform?(%w{centos redhat fedora})
	code <<-EOH 
		wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
		rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key		
	EOH
end
  
end

package "jenkins" do
  action :upgrade
end

# bash "start_jenkins" do
# user "root"
#   cwd "/tmp"
#   code <<-EOH
#     sudo /etc/init.d/jenkins start
#   EOH
# end

ruby_block "wait_for_server_to_start" do
  block do
    sleep 20
  end
  action :create
end