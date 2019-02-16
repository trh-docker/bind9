FROM quay.io/spivegin/tlmbasedebian
ENV DINIT=1.2.2

WORKDIR /opt/bind9

ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD https://github.com/Yelp/dumb-init/releases/download/v${DINIT}/dumb-init_${DINIT}_amd64.deb /tmp/dumb-init_amd64.deb
ADD files/webmin/webmin_1.900_all.deb /tmp/webmin_1.900_all.deb

# Installing dunb-init and adding Adfreezone Cert Auth
RUN update-ca-certificates --verbose &&\
    dpkg -i /tmp/dumb-init_amd64.deb && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Installing Bind9
RUN apt update && apt install -y bind9 bind9utils bind9-doc &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Installing Bind9
RUN apt update && apt install -y perl libnet-ssleay-perl openssl libauthen-pam-perl \
    libpam-runtime libio-pty-perl apt-show-versions python apt-transport-https aptitude python-pip &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
