# Bind9 with Webmin

Webmin runs on port 10000

'''
docker run -it -p 80:80 -p 53:53 -p 53:53/udp -e PASSWORD=YourRootPassword quay.io/spivegin/bind9

docker run -d -p 80:80 -p 53:53 -p 53:53/udp -e PASSWORD=YourRootPassword quay.io/spivegin/bind9
'''
updated webmin to 1.953
