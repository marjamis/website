---
title: Arch Linux Installation
heroImage: "https://archlinux.org/static/logos/archlinux-logo-dark-1200dpi.b42bd35d5916.png"
---

The linux world changes so fast, relatively at least, and I dont install Arch Linux that regularly to remember every little step or enough to have every step specifically documented for myself so Im going to rely on other documentation and modify the steps when it's required.

For that purpose the below is my recommended order of looking over documentation to job my memory:

1. [Arch Linux's Installation Guide](https://wiki.archlinux.org/title/Installation_guide) - as this generally has nearly all the steps I need when installing from scratch
1. Search Arch Linux documentation for any additional details for steps that I may need at the time. Usually things like cryptsetup/LUKS, grub, etc. Some specifics to remember:
    1. [Connecting to a Wireless network](https://wiki.archlinux.org/title/Iwd#iwctl) - though keep in mind connecting to hidden networks always fails for me from here
    1. When using pacstrap remember to run the following to install some additional packages for ease in setup: `pacstrap -K /mnt base linux linux-firmware NetworkManager plasma-desktop sddm sddm-kcm`
    1. Enable services to run automatically:
        1. `systemctl enable sddm.service`
        1. `systemctl enable NetworkManager.service`
    1. Create my user, with a password, before exiting the arch-chroot environment. Makes it easier for the KDE setup later
1. [Dreams of Autonomy - How I install Arch Linux (the hard way)](https://www.youtube.com/watch?v=YC7NMbl4goo) - as this is nearly identical to my preferred setup for Arch Linux, beyond a few small non-important variations
1. Framework specific items
    1. https://wiki.archlinux.org/title/Framework_Laptop_13
    1. https://community.frame.work/t/arch-linux-on-the-framework-laptop-13/3843
    1. https://community.frame.work/t/bios-guide/4178
1. Use my dotfiles repo for everything else
1. Install Wallpapers, both desktop and the lock screen
