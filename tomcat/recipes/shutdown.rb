#
# Cookbookname: tomcat
# Recipe:: shutdown.rb
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Uninstall Tomcat
script "uninstall_tomcat" do
  interpreter "bash"
  user "root"
  code <<-EOH
    tomcatv=`ps -eLf|grep tomcat | cut -d ' ' -f 1 | head -1`
    if [[ $tomcatv == tomcat* ]];
    then
      sudo apt-get --force-yes purge $tomcatv
      sudo apt-get --force-yes autoremove
      sudo rm -r /usr/share/$tomcatv
    fi
  EOH
end
