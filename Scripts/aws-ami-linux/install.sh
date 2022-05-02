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

# starting plugin install
yes | yum install -y gcc glibc glibc-common make gettext automake autoconf wget openssl-devel net-snmp net-snmp-utils epel-release
yes | yum install -y perl-Net-SNMP
# get the source
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.3.3.tar.gz
tar zxf nagios-plugins.tar.gz
# build it
cd /tmp/nagios-plugins-release-2.3.3/
./tools/setup
./configure
yes | make
yes | make install
# restart nagios 
systemctl restart nagios
