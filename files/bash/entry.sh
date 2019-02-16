#!/usr/bin/dumb-init /bin/sh

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