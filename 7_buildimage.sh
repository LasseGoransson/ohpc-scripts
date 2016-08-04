export CHROOT=/opt/ohpc/admin/images/centos7.2
wwbootstrap `uname -r`
wwvnfs -y --chroot $CHROOT
