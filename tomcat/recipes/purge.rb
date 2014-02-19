ruby_block "find-tomcat-old-version" do
  block do
    current_server = `ps -eLf|grep -Eo '^[^ ]+'| grep tomcat`
    if parts = current_server.match(/tomcat([0-9])/)
      ver = parts.captures.join("")
      node.override['tomcat']['old_server'] = ver
      puts "************************#{node['tomcat']['old_server']}****************"
      
    end
  end
  action :create
end

log "===============#{node.override['tomcat']['old_server']}=============================" do
  level :info
end

tomcat_pkgs = value_for_platform(
  ['debian', 'ubuntu'] => {
    'default' => ["tomcat#{node['tomcat']['old_version']}", 'libtcnative-1', 'libmysql-java']
  },
  ['centos', 'redhat', 'fedora', 'amazon'] => {
    'default' => ["tomcat#{node['tomcat']['old_version']}", 'tomcat-native', 'mysql-connector-java']
  },
  'default' => ["tomcat#{node['tomcat']['old_version']}"]
)

tomcat_old_version = "tomcat#{node['tomcat']['old_version']}"
tomcat_current_version = "tomcat#{node['tomcat']['base_version']}"

tomcat_pkgs.each do |pkg|
  package pkg do
    action :purge
  end
end

script "uninstall_tomcat" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if [ -d "/usr/share/#{tomcat_old_version}" ]
    then
      sudo rm -rf /usr/share/#{tomcat_old_version}
    fi
    if [ -d "/usr/share/#{tomcat_current_version}" ]
    then
      sudo rm -rf /usr/share/#{tomcat_current_version}
    fi
    if [ -d "/var/lib/#{tomcat_old_version}" ]
    then
      sudo rm -rf /var/lib/#{tomcat_old_version}
    fi
    if [ -d "/var/lib/#{tomcat_current_version}" ]
    then
      sudo rm -rf /var/lib/#{tomcat_current_version}
    fi
  EOH
end
