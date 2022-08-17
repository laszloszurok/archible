# Archible

Ansible roles to install and configure ArchLinux

## Usage

The playbook with these roles are supposed to be run on the machine that you want to install Arch on.
You have to boot into Arch from an installation medium and install the ansible-core and ansible packages, then clone this repo and run the playbook with local connection.

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

* increase the disk size for the live environment

```shell
mount -o remount,size=1G /run/archiso/cowspace
```

* install git, ansible and it's python dependencies

```shell
pacman -Sy git ansible-core ansible python-packaging python-jmespath
```

## Usage example

### Example playbook

```yaml
- hosts: archiso
  connection: local
  roles:
    - arch_init

- hosts: chroot
  connection: chroot
  roles:
    - arch_config
```

### Variables should be set in the group_vars directory

group_vars/all/partitions.yml

```yaml
install_drive: /dev/nvme0n1
boot_partition_suffix: p1
swap_partition_suffix: p2
root_partition_suffix: p3
```

group_vars/chroot/config.yml

```yaml
# The description field is not used anywhere, it's just for readability. 
# A simple list without descriptions can be used too eg. [ acpilight, bat ]
arch_config_standard_packages:
  - { package: acpilight, description: 'control screen brightness (cmd: xbacklight)' }
  - { package: bat,       description: 'a pager with colors' }
arch_config_timezone: Europe/Budapest
arch_config_locale: en_US.UTF-8
arch_config_user_name: myuser
arch_config_user_password: mypassword
arch_config_user_groups: wheel
arch_config_hostname: myhostname
```

```shell
ansible-playbook -i inventory playbook.yml
```
