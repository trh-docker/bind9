#!/usr/bin/dumb-init /bin/sh

echo "root:${PASSWORD}" | chpasswd 
named -f -u bind &
/etc/webmin/start





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
