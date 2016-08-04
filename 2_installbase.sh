yum -y groupinstall ohpc-base
yum -y groupinstall ohpc-warewulf
systemctl disable firewalld
systemctl stop firewalld
systemctl enable ntpd.service
echo "server 10.0.0.1" >> /etc/ntp.conf
systemctl restart ntpd
