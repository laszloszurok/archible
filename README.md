# Archible

Ansible roles to install and configure ArchLinux

## Usage

The playbook with these roles are supposed to be run on the machine that you want to install Arch on.
You have to boot into Arch from an installation medium and install the ansible-core and ansible packages, then run the playbook against localhost.

## Prerequisites

* update the system clock

```shell
timedatectl set-ntp true
```

* refresh pacman's gpg keys to be able to install packages

    * stop gpg-agent

    ```shell
    killall gpg-agent
    ```

    * delete the files under /etc/pacman.d/gnupg/

    ```shell
    rm -rf /etc/pacman.d/gnupg/*
    ```

    * reinitialize the keyring

    ```shell
    pacman-key --init
    ```

    * reload the default keys from the archlinux keyring

    ```shell
    pacman-key --populate archlinux
    ```

* increased the disk size for the live environment

```shell
mount -o remount,size=1G /run/archiso/cowspace
```
