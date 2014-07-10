log_level                :info
log_location             STDOUT
node_name                "trananbinh110"
client_key               "#{current_dir}/trananbinh110.pem"
validation_client_name   "unsw-thesis---nicta-validator"
validation_key           "#{current_dir}/unsw-thesis---nicta-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/unsw-thesis---nicta"
syntax_check_cache_path  "#{current_dir}/syntax_check_cache"
cookbook_path            [ "#{current_dir}/../cookbooks" ]

knife[:aws_access_key_id] = 'AKIAJ4K5FO3KGMGGPXOA'
knife[:aws_ssh_key_id] = 'chef'
knife[:aws_secret_access_key] = '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'
