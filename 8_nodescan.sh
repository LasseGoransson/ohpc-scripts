echo "GATEWAYDEV=ens19" > /tmp/network.$$
wwsh  file import /tmp/network.$$ --name network
wwsh  file set network --path /etc/sysconfig/network --mode=0644 --uid=0

wwnodescan --netdev=ens19 --ipaddr=10.0.0.10 --netmask=255.255.255.0 --vnfs=centos7.2 --bootstrap=`uname -r` c[1-3]
wwsh pxe update
wwsh -y provision set c[1-3] --vnfs=centos7.2 --bootstrap=`uname -r` --files=dynamic_hosts,passwd,group,shadow,slurm.conf,munge.key,network
