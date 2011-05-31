#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

cookbook_file "/tmp/config.xml" do
  source "config.xml"
  action :create
end

cookbook_file "/tmp/hudson-cli.jar" do
  source "hudson-cli.jar"
  action :create
end

bash "create_hudson_job" do
  user "root"
  cwd "/tmp"
  code <<-END
  java -jar ./hudson-cli.jar -s http://localhost:8080/ delete-job "#{node[:hudson][:server][:job]}"
  java -jar ./hudson-cli.jar -s http://localhost:8080/ create-job "#{node[:hudson][:server][:job]}" < ./config.xml
  END
end

modules = [
  "analysis-collector",
  "analysis-core",
  "backup",
  "checkstyle",
  "clover",
  "dry",
  "git",
  "greenballs",
  "pmd",
  "violations",
  "warnings",
  "xunit"
]

modules.each do
  |mod|
  bash "install_" + mod do
    user "root"
    cwd "/tmp"
    code "java -jar ./hudson-cli.jar -s http://localhost:8080/ install-plugin " + mod
  end
end

link "/var/lib/hudson/jobs/#{node[:hudson][:server][:job]}/workspace" do
  owner "hudson"
  group "nogroup"
  to "/mnt/hgfs/Sites/3663.development.local/"
end

bash "restart_hudson" do
  user "root"
  cwd "/tmp"
  code <<-END
    java -jar ./hudson-cli.jar -s http://localhost:8080/ build  "#{node[:hudson][:server][:job]}"
    java -jar ./hudson-cli.jar -s http://localhost:8080/ safe-restart
  END
end
