---
layout: default
title: Configuring and using LUKS
date: 2016-09-26 20:15:10 +11:00
categories:
  - linux
  - example
---

## {{ page.title }}

### Create a LUKS encrypted partition

To create the luks volume on a block device:

```bash
cryptsetup luksFormat --cipher aes-xts-plain64 -v --key-size 512 --hash sha512 --iter-time 5000 --use-urandom --verify-passphrase <device>
```

### Create a keyfile and add it to an existing device

The below creates a 4096 bit key:

```bash
dd bs=512 count=8 if=/dev/urandom of=/etc/mykeyfile iflag=fullblock
```

This will add the keyfile to the existing encrypted device:

```bash
cryptsetup luksAddKey /dev/sda2 /etc/mykeyfile
```

### Open the LUKS encrypted parition

#### One time

```bash
cryptsetup luksOpen <encrypted_device> <mapper_name>
```

#### On boot via fstab

Once the disk has LUKS and a file system on it, to automate the mount you will need an entry in /etc/fstab such as:

```config
/dev/mapper/<mapper_name>    <mount_location>   <file_system_type>   defaults   1   2
```

and so there is no need for a password/key manually entered add the entry into /etc/crypttab such as:

```config
<mapper_name>         <device>       <password or preferred location to the key>
```

#### On boot via vmlinuz image(Used for / encrypted boots)

In grub.cfg for the linux line have:

```config
linux   /vmlinuz-linux root=/dev/mapper/<vg_name>-<lv_name> cryptdevice=/dev/disk/by-uuid/<uuid_of_device>:<vg_name> rw quiet
```
