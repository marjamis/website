---
layout: default
title: Interesting Linux Commands
---

## {{ page.title }}

### Command line

| Command/s | Use |
| --- | --- |
| # mount -t  tmpfs -o size=\<size\> tmpfs \<location_of_mount\> && mount -t  ramfs -o size=\<size\> ramfs \<location_of_mount\> | Create an in-memory mounted disk |
| ddrescuse | dd copy even if there is an issue with reading some blocks |
| mktemp /tmp/\<name\>.\<At least 3 X's which will be randomised\> | Create temporary files **NOTE:** This can be specified witha template to have a specific way to generate the random part. |
| mktemp -d /tmp/\<name\>.\<At least 3 X's which will be randomised\> | Create temporary directory **NOTE:** This can be specified with a template to have a specific way to generate the random part. |
| echo $RANDOM | The "shell variable" can be used to generate a random number(only suitable for basic random numbers) |
| echo 'tesjklsjg thi value' \| tee >(rev) >(tr ' ' '_') >(rev) >(rev) >(tr ' ' 'b') Tofile && sleep 1; | Basic example of tee being redirected to multiple commands as stdin as well as the original data outputted to a file called Tofile, I have also added a sleep at conditionally on the command line completing as the prompt on occasion came back prior to the executing each command. |
| date -d @\<milliseconds\> | Epoch for Linux |
| dd if=/dev/sda1 \| bzip2 -9 > disk.img | Use to create an image of a hdd |
| sudo lsof -i :\<port\> | List all process running a specfic port |
| netstat -anl | See a list of ports running |
| lsusb | List connected USB devices |
| kill -USR1 \<dd pid\> | Check progress of dd - You can send the signal USR1 to the dd process which will report statistics on each progress |
| lsof +L1 | List all files with a linkcount of 0 - i.e. usually deleted but open **NOTE:** This is useful if a file is deleted by not reflected in df. Many other uses. |
| tar -cvp '2011_03_13/' \| split -d -b 4000m - archive.tar.bz2 | Backup directory 2011_03_13 and split archive into 4GB chunks |
| cat archive.tar.bz2.0* \| tar -xpvf - | Recreate archive from chunks |
| cat <<'EOF' - email \| sendmail -t \\ To: \<address\> \\ Subject: hello \\ Content-Type: text/html \\ \\ EOF | Send a html email via CLI |
| grep \-\- -v \<file\> | Bare double dash - means the cli will take anything after as positional arguments and not options. -v not an option but whats searched on, easier that "'s all over the place |
| pidof \<name of application\> | Find the PID of the named application |
| pivot_root | Change the root filesystem location, useful for testing |
| switch_root | Will change all the mounts to the new root location specified. Moves /proc, /dev, etc. |
| mkfifo \<name\>, Shell 1: gzip -9 -c < my_pipe > out.gz, Shell 2: cat file > my_pipe | Named Pipe/FIFO for interprocess communication(IPC). Example is used to compress a file but this can be used for many purposes. |
| mount --bind olddir newdir | Remount part of the file hierarchy somewhere else. Makes both locations access the same files undre the olddir and newdir. See bind mounts with df -aT|
| curl -v -s -L -o /dev/null -w http_code="%{http_code}\n\  "time_namelookup="%{time_namelookup}\n\  "time_connect="%{time_connect}\n\   "time_pretransfer="%{time_pretransfer}\n\ "time_starttransfer="%{time_starttransfer}\n\  "num_connects="%{num_connects}\n\   "speed_download="%{speed_download}\n\  "speed_upload="%{speed_upload}\n\  "ssl_verify_results="%{ssl_verify_result}\n\  "time_total="%{time_total}\n" \<cloudfront URL\> | Get breakdown of time to transfer via Cloud Front |

### Settings

| File | Setting | Use |
| --- | --- | --- |
| .bashrc file | TMOUT=300 | Auto logout of session - In a users .bashrc file there can be a variable TM=\<amount of time in seconds\> which can control the auto logout functionality. For example the below will auto logout a user after 5 mins of inactivity. |
| /etc/fstab | _netdev | Mounting network drives to OS on boot - **NOTE:** Works for RHEL and CentOS, but haven't found any such settings in other OS's, needs testing. Due to the ordering of steps in booting the OS this can cause an issue if the networking isn't up yet, add this option for that mount point and it will attempt a mounting of that once the network is up and running. |
| /boot/grub/grub.cfg | rhgb quiet | See the messages behind a boot splash screen - Remove this configuration from grub.cfg **NOTE:** This is for RHEL and CentOS. |
