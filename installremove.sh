#!/bin/bash

uninstall_mcaffee() {

if [ -n "rpm -qa|egrep 'MFEcma|MFErt'" ];then
   rpm -qa|egrep 'MFEcma|MFErt'|xargs rpm -e
else
   echo "No McAffee agent installed"
fi
}

wazuh_install() {
if [ -n "rpm -qa|egrep 'wazuh-agent'" ];then
   rpm -Uvh /var/tmp/wazuh-agent-3.9.5-1.x86_64.rpm
else
   echo "No McAffee agent installed"
fi
}

remove_mcafee_install() {
if [ -e /var/tmp/mcafee-installer.sh ];then
   rm -rf /var/tmp/mcafee-installer.sh
else
  echo "Installer does not exists"
fi

}

remove_mcafee_cron(){
if [ -n `grep '0,30 * * * * /opt/McAfee/agent/scripts/ma checkhealth' /var/spool/cron/root` ];then
  sed -i 's/\0,30 * * * * \/opt\/McAfee\/agent\/scripts\/ma checkhealth//' /var/spool/cron/root
else
  echo "mcafee is not on crontab"
fi
}

add_cron_entry() {
if [ -n `grep '^installremove.sh' /var/spool/cron/root` ];then
   echo '* * * * * /usr/local/bin/installremove.sh' >> /var/spool/cron/root
else
   echo "script already in crontab"
fi

}


uninstall_mcaffee
wazuh_install
remove_mcafee_install
remove_mcafee_cron
add_cron_entry
