ruby_block "find-tomcat-old-version" do
  block do
    current_server = `ps -eLf|grep -Eo '^[^ ]+'| grep tomcat`
    if parts = current_server.match(/tomcat([0-9])/)
      ver = parts.captures.join("")
      node.default['tomcat_old_server'] = ver
      puts "************************#{node.default['tomcat_old_server']}****************"
      puts "^^^^^^^^^^^^^^^^^In else statement, #{node['tomcat']['old_version']}^^^^^^^^^^^^^^"
    else
      node.default['tomcat_old_server'] = node['tomcat']['old_version']
    end
  end
  action :create
end

ruby_block "print-tomcat-old-server" do
  block do
    puts "************************#{node['tomcat_old_server']}****************"
    tomcat_pkgs = value_for_platform(
    ['debian', 'ubuntu'] => {
     'default' => ["tomcat#{node['tomcat_old_server']}", 'libtcnative-1', 'libmysql-java']
    },
    ['centos', 'redhat', 'fedora', 'amazon'] => {
     'default' => ["tomcat#{node['tomcat_old_server']}", 'tomcat-native', 'mysql-connector-java']
    },
    'default' => ["tomcat#{node['tomcat_old_server']}"]
    )
    tomcat_old_version = "tomcat#{node['tomcat_old_server']}"
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
    
  end
end

#log "===============#{node['tomcat_old_server']}=============================" do
#  level :info
#end








