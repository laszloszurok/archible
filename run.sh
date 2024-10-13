#!/bin/sh

timedatectl set-ntp true
mount -o remount,size=1G /run/archiso/cowspace
pacman -Sy git ansible-core ansible python-packaging python-jmespath python-passlib
ansible-playbook --inventory inventory playbook.yml
