yum install net-tools -y
perl -pi -e "s/device = eth1/device = ens19/" /etc/warewulf/provision.conf
perl -pi -e "s/^\s+disable\s+= yes/ disable = no/" /etc/xinetd.d/tftp
export MODFILE=/etc/httpd/conf.d/warewulf-httpd.conf
perl -pi -e "s/cgi-bin>\$/cgi-bin>\n Require all granted/" $MODFILE
perl -pi -e "s/Allow from all/Require all granted/" $MODFILE
perl -ni -e "print unless /^\s+Order allow,deny/" $MODFILE

cat >/etc/sysconfig/network-scripts/ifcfg-ens19 <<EOL
DEVICE=ens19
BOOTPROTO=none
ONBOOT=yes
NETMASK=255.255.255.0
IPADDR=10.0.0.1
USERCTL=no
EOL

ifconfig ens19 10.0.0.1 netmask 255.255.255.0 up
systemctl restart xinetd
systemctl enable mariadb.service
systemctl restart mariadb
systemctl enable httpd.service
systemctl restart httpd
