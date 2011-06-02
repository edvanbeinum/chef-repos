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
  ["centos", "redhat", "fedora", "suse"] => {"default" => %w(ant)},
  "default" => %w{ant}
)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

bash "install_jenkins_rpm" do
user "root"
  cwd "/tmp"
  if platform?(%w{debian ubuntu})
      code <<-EOH
      wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
      sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
      apt-get update
      EOH
  elsif platform?(%w{centos redhat fedora})
      code <<-EOH
      wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
      rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
      EOH
  end

end

package "jenkins" do
  action :upgrade
end


ruby_block "wait_for_server_to_start" do
  block do
    sleep 30
  end
  action :create
end