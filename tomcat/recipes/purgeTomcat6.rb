tomcat_pkgs = value_for_platform(
  ['debian', 'ubuntu'] => {
    'default' => ["tomcat#{node['tomcat']['base_version']}", 'libtcnative-1', 'libmysql-java']
  },
  ['centos', 'redhat', 'fedora', 'amazon'] => {
    'default' => ["tomcat#{node['tomcat']['base_version']}", 'tomcat-native', 'mysql-connector-java']
  },
  'default' => ["tomcat#{node['tomcat']['base_version']}"]
)

tomcat_version = "tomcat#{node['tomcat']['base_version']}"

tomcat_pkgs.each do |pkg|
  package pkg do
    action :remove
  end
end

script "uninstall_tomcat" do
  interpreter "bash"
  user "root"
  code <<-EOH
    sudo rm -rf /usr/share/#{tomcat_version}
    if [ -d "/var/lib/#{tomcat_version}" ]
    then
      sudo rm -rf /var/lib/#{tomcat_version}
    fi
  EOH
end
