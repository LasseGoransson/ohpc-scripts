yum -y groupinstall ohpc-slurm-server
useradd slurm
sed -i 's/SlurmctldPidFile=\/var\/run\/slurmctld.pid/SlurmctldPidFile=\/tmp\/slurmctld.pid/g' /etc/slurm/slurm.conf
