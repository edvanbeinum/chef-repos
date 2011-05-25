current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                'astead'
client_key               "#{current_dir}/astead.pem"
validation_client_name   "ibuilding-dreams-validator"
validation_key           "#{current_dir}/ibuildings-dreams-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/ibuildings-dreams"
cache_type               "BasicFile"
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path [ "#{current_dir}/../cookbooks", "#{current_dir}/../site-cookbooks" ]

# Cookbook generation details
cookbook_copyright "Alistair Stead"
cookbook_email     "alistair.stead@designdisclosure.com"
cookbook_license   "apachev2"

# Rackspace:
knife[:rackspace_api_key]  = "bbb3943746f0d83ec9102333c4a9c716"
knife[:rackspace_api_username] = "leftfielddigital"
