#!/bin/bash

service ssh start

addgroup --gid $gid $gname
adduser --disabled-password --gecos '' --uid $uid --gid $gid $uname
adduser $uname sudo
usermod --password $(echo $password | openssl passwd -1 -stdin) $uname
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

su $uname
