#!/bin/bash

pword=Password1234


echo Nagios Install Running
wait 3

yes | yum install -y gcc glibc glibc-common wget unzip httpd php gd gd-devel perl postfix
yes | yum install openssl-devel

cd /tmp
yes | wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
yes | tar xzf nagioscore.tar.gz
wait 2

cd /tmp/nagioscore-nagios-4.4.6/
yes | ./configure
yes | make all
wait 2

make install-groups-users
usermod -a -G nagios apache
wait 2

yes | make install
wait 2

yes | make install-daemoninit
systemctl enable httpd.service
wait 2

yes | make install-commandmode
wait 2

yes | make install-config
wait 2

yes | make install-webconf
wait 5

echo $pword | htpasswd -c -i /usr/local/nagios/etc/htpasswd.users nagiosadmin
wait 10

systemctl start httpd.service
echo webserver started
wait 2

systemctl start nagios.service
echo Nagios Started Please Browse to port 80 and confirm core install is working