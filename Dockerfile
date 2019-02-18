FROM quay.io/spivegin/tlmbasedebian
ENV DINIT=1.2.2

WORKDIR /opt/bind9

ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD https://github.com/Yelp/dumb-init/releases/download/v${DINIT}/dumb-init_${DINIT}_amd64.deb /tmp/dumb-init_amd64.deb

# Installing dunb-init and adding Adfreezone Cert Auth
RUN update-ca-certificates --verbose &&\
    dpkg -i /tmp/dumb-init_amd64.deb && \
    mkdir /opt/bin &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Installing Bind9
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Installing Webmin Depends p1
RUN apt-get update && apt-get install -y perl libnet-ssleay-perl openssl libauthen-pam-perl \
    libpam-runtime libio-pty-perl python apt-utils curl git &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
# Installing Webmin Depends p2
RUN apt-get update &&\
    cd /var/cache/debconf && rm *.dat &&\
    rm /etc/apt/apt.conf.d/docker-gzip-indexes &&\
    apt-get purge apt-show-versions &&\
    rm /var/lib/apt/lists/*lz4 &&\
    apt-get -o Acquire::GzipIndexes=false update &&\
    apt-get install -y apt-show-versions &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD files/webmin/webmin_1.900_all.deb /tmp/webmin_1.900_all.deb
# Installing Webmin
RUN dpkg -i /tmp/webmin_1.900_all.deb &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN mkdir /opt/bind9/tmp
ADD files/bash/entry.sh /opt/bin/
ADD files/webmin/miniserv.conf /etc/webmin/miniserv.conf
RUN chmod +x /opt/bin/entry.sh
EXPOSE 53 53/udp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]