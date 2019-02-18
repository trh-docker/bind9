#!/usr/bin/dumb-init /bin/sh

echo "root:${PASSWORD}" | chpasswd 
if [ -f /opt/bind9/tmp/config ]
then
    echo Copping config
    cp /opt/bind9/config /etc/webmin/config
fi
if [ -f /opt/bind9/tmp/miniserv.conf ]
then
    echo Copping miniserv.conf
    cp /opt/bind9/tmp/miniserv.conf /etc/webmin/miniserv.conf
fi
/etc/webmin/start &
named -f -u bind 





# [Unit]
# Description=BIND Domain Name Server
# Documentation=man:named(8)
# After=network.target

# [Service]
# ExecStart=/usr/sbin/named -f -u bind
# ExecReload=/usr/sbin/rndc reload
# ExecStop=/usr/sbin/rndc stop

# [Install]
# WantedBy=multi-user.target

# pas=$1
# echo -e "$pas\n$pas" | passwd -q root
