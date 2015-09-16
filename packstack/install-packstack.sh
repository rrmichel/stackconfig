#!/bin/bash

function die() {
	echo "Usage: $0 [yes] [answer-file]"
	exit 1
}

[[ $1 == yes ]] || die

ANSFILE="$2"

[[ -e $ANSFILE ]] || die

# disable SELinux
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
setenforce 0

# install rdo repo and software
yum update -y
yum install -y https://rdoproject.org/repos/rdo-release.rpm
yum install -y openstack-packstack screen vim

# run packstack with answer file
screen -S packstack packstack --answer-file=$ANSFILE
