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

* increase the disk size for the live environment

```shell
mount -o remount,size=1G /run/archiso/cowspace
```

* install git, ansible and it's python dependencies

```shell
pacman -Sy git ansible-core ansible python-packaging python-jmespath python-passlib
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

### Example variables

group_vars/all/partitions.yml

```yaml
install_drive: /dev/nvme0n1
boot_partition_suffix: p1
swap_partition_suffix: p2
root_partition_suffix: p3
```

group_vars/chroot/config.yml

```yaml
arch_config_standard_packages:
  - acpilight
  - bat
arch_config_timezone: Europe/Budapest
arch_config_locale: en_US.UTF-8
arch_config_user_name: my_user
arch_config_user_password: my_password_hash
arch_config_user_groups: wheel
arch_config_hostname: my_hostname
```

```shell
ansible-playbook -i inventory playbook.yml
```
