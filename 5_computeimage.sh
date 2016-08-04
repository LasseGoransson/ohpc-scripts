export sms_ip=10.0.0.1
export sms_name=head1.lan
export CHROOT=/opt/ohpc/admin/images/centos7.2
wwmkchroot centos-7 $CHROOT
cp -p /etc/resolv.conf $CHROOT/etc/resolv.conf
yum -y --installroot=$CHROOT groupinstall ohpc-slurm-client
yum -y --installroot=$CHROOT install ntp
yum -y --installroot=$CHROOT install kernel
yum -y --installroot=$CHROOT install lmod-ohpc

wwinit ssh_keys
echo "${sms_ip}:/home /home nfs nfsvers=3,rsize=1024,wsize=1024,cto 0 0" >> $CHROOT/etc/fstab
cat ~/.ssh/cluster.pub >> $CHROOT/root/.ssh/authorized_keys
echo "${sms_ip}:/opt/ohpc/pub /opt/ohpc/pub nfs nfsvers=3 0 0" >> $CHROOT/etc/fstab
perl -pi -e "s/ControlMachine=\S+/ControlMachine=${sms_name}/" /etc/slurm/slurm.conf


yum -y install nfs-utils
echo "/home *(rw,no_subtree_check,fsid=10,no_root_squash)" >> /etc/exports
echo "/opt/ohpc/pub *(ro,no_subtree_check,fsid=11)" >> /etc/exports
exportfs -a
systemctl restart nfs
chroot $CHROOT systemctl enable ntpd
echo "server ${sms_ip}" >> $CHROOT/etc/ntp.conf
