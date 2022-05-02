#!/bin/bash
# install from package
cd /tmp/
#makethruk folder
mkdir thruk
cd thruk/
#thruklibs
wget https://download.thruk.org/pkg/v2.48/rhel7/x86_64/libthruk-2.48-0.rhel7.x86_64.rpm
#thruk
wget https://download.thruk.org/pkg/v2.48/rhel7/x86_64/thruk-2.48-11430.1.rhel7.x86_64.rpm
#thrukbase
wget https://download.thruk.org/pkg/v2.48/rhel7/x86_64/thruk-base-2.48-11430.1.rhel7.x86_64.rpm
#thrukreporting
wget https://download.thruk.org/pkg/v2.48/rhel7/x86_64/thruk-plugin-reporting-2.48-11430.1.rhel7.x86_64.rpm
# install Thruk
yes | yum install libthruk-2.48-0.rhel7.x86_64.rpm
yes | yum install thruk-base-2.48-11430.1.rhel7.x86_64.rpm
yes | yum install thruk-plugin-reporting-2.48-11430.1.rhel7.x86_64.rpm
yes | yum install --nogpgcheck thruk-2.48-11430.1.rhel7.x86_64.rpm
#start apache ships on ami
systemctl start httpd
#enable apache 
systemctl enable httpd

#Reset admin login
