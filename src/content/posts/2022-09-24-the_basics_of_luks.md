---
title: The basics of LUKS
description: PENDING
publishDate: 2022-09-24 16:15:43 +1000
heroImage: "/blog-placeholder-5.jpg"

categories:
  - example
  - linux
---

I recently had a bit of an encrypted data scare where I somehow locked myself out of my LUKS encrypted data volume and nearly lost all my data. Yikes. Thankfully I don't have anything that imporatant but it would've still been a bit of a hassle to loose. That scare, and the subsequent steps to recover, made me think I should revisit my 10+ year old encryption process and update it a bit to add a few more key verification steps than I've had in the past. Let me walk you through my general implementation.

The first step is the creation of a volume that I can encrypt with LUKS. In my case I wanted something that acted like a disk while not actually being a physical disk. This was for two reasons, one I don't have anywhere near enough data to require even the smallest of storage devices, and the other is that I wanted it to be a single file that contained all my data which I could then easily copied and backed up where ever I needed to, such as to other physical disks, or object stores, like S3 and Google Drive.

To that end I make use of a loopback file which is basically a file on a disk that is created in such a way that it can be used as if it was itself a disk. The way I create these files is with dd which creates a file of random data with the size that I need:

```bash
dd if=/dev/urandom of=./test_encryption_file bs=1M count=300
```

In this case my command creates a local file, named test_encryption_file, of 300MB. Once I have file I now need to format it with LUKS. There are many, many flags that can be used to configure exactly how LUKS encrypts the data, for eaxample the ciphers used, but in my case I have pretty basic needs so I'll use the defaults. The command I use to create my encrypted data volume with a passphrase is:

```bash
cryptsetup luksFormat --type luks2 --verify-passphrase test_encryption_file
```

With LUKS you can have multiple methods to open the encrypted volume, the two most common in my mind being a passphrase, analogous to a password, and a key, a file of random data. Keys generally are more secure as they have larger sizes than passphrases, hence harder to crack but also require the securing and backing up of this file. After my scare I've decided that my new approach, is to have both a passphrase and a key where either can be used to open my encrypted data volume. This is to ensure I can use the encrypted data volume as I normally would, via a passphrase, but if something ever happens to this passphrase I have the key as a backup method. I will also have to backup this key file somewhere secure but that's a small price to pay to ensure this data continues to be accessible. The way I generate key files is with dd again:

```bash
dd bs=512 count=8 if=/dev/urandom of=./mykeyfile iflag=fullblock
```

Note that I use /dev/urandom as the input, this is important as I want the key to be as random as possible. Any method that provides random data could be used but this is generally an easy Linux way to do this. Once I have this key file I need to add the key to LUKS as a method to decrypt the volume:

```bash
cryptsetup luksAddKey test_encryption_file ./mykeyfile
```

Once I have my keys added I need to open up the encrypted volume so that it can be used. I do this with:

```bash
# Using the passphrase
sudo cryptsetup open test_encryption_file encrypted_data_volume

# Using the key, also useful for scripts
sudo cryptsetup open --key-file <location_of_key_file> test_encryption_file encrypted_data_volume
```

Once I have my volume open, and verified I can open it with both the passphrase and the key, I still need a file system on it to be able to add my files. When you open the volume it creates a psuedo device with **device mapper (dm)** allowing it to be treated as if it was a physical disk and "maps" it as a psuedo device under /dev/mapper with the name specified with the `cryptsetup open`.

Using this newly created device I can now create a file system on it with the normal Linux file system commands. Generally my filesystem of choice is ext4, as it's a stable general purpose file system, and is generally compatable on all Linux distributions without any additional setup. For example to create the file system and mount it I run:

```bash
sudo mke2fs -t ext4 /dev/mapper/encrypted_data_volume
sudo mount /dev/mapper/encrypted_data_volume /mnt
```

I now have a file system mounted on /mnt where I can add my files to.

Once I'm done with my mounted encrypted data volume I close it off by unmounting the file system and closing the LUKS encrypted "disk".

```bash
# Unmount the filesystem
sudo umount /mnt

# Close the volume with LUKS
sudo cryptsetup close encrypted_data_volume
```

With these steps complete, my data within the volume is still encrypted but now I can copy this "file" of encrypted data wherever I need.

There are many additional configurations that can be used with LUKS that I haven't covered, such as:

- Auto-mounting the disk with the use of /etc/fstab and /etc/crypttab
- Using scripts to mount the encrypted data volumes
- Backing up the header files of the encrypted data volumes in case of corruption (I may come back to edit this post with that information)
- Full disk encryption, i.e. encrypting full physical disks for the OS' and data. This is extremely common in the IT world as requirement for employees and is often accomplished relatively seemless during installation of your OS. When attempting this yourself, I would recommend following your Linux distribution documentation for these steps but essentially the general steps are what are listed above but instead of being a loopback file its using cryptsetup against the physical disk used for booting the OS. With some additional steps to ensure your bootloader, usually grub, has the information and tools to open an encrypted device.
- Plus I'm sure many others

To learn more about LUKS, [Arch Linux](https://archlinux.org/) has a [great wiki](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system) to help explore this more. While it is meant specifically for Arch, my distro of choice, there is plenty of useful information about the process that could help with most distributions.

And there you have it, LUKS data encryption in a nut shell.
