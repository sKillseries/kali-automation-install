#!/usr/bin/env bash
# Ref: https://www.vagrantup.com/docs/boxes/base.html

# Add the vagrant insecure pub key
mkdir /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
chmod 0700 /home/vagrant/.ssh/
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh/

# Password-less sudo for vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# SSH tweak
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Fix the DHCP NAT
echo -e "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces
