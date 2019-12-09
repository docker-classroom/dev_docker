#!/bin/bash

if [[ -z "$password" ]]
then
    password=abc
else
    service ssh start
fi

addgroup --gid $gid $gname
adduser --disabled-password --gecos '' --uid $uid --gid $gid $uname
adduser $uname sudo
usermod --password $(echo $password | openssl passwd -1 -stdin) $uname
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

chown $uname:$gname /home/$uname

su $uname
