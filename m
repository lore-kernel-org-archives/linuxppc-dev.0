Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "XOL" <xol@mail.ru>
To: linuxppc-embedded@lists.linuxppc.org
Subject: initrd for MPC860/862 with eldk2.1.10
Mime-Version: 1.0
Date: Thu, 05 Jun 2003 17:18:08 +0400
Reply-To: "XOL" <xol@mail.ru>
Content-Type: text/plain; charset=koi8-r
Message-Id: <E19Nud6-000EGg-00.xol-mail-ru@f16.mail.ru>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.
I'm trying to boot my 862 board from EP.
I have eldk-2.1.10 and kernel 2-4-18
Booting from nfs works ok.
I made kernel+initrd image and try to boot it via
tftp first before burning it to flash. I'm getting following message from kernel

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:3a:de
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
crc errorFreeing initrd memory: 4951k freed
VFS: Mounted root (ext2 filesystem).
Warning: unable to mount devfs, err: -2
Freeing unused kernel memory: 52k init
Warning: unable to open an initial console.
EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in directory #39: unaligned directory entry - offset=1024, inode=318774272, rec_len=27649, name_len=105
Kernel panic: No init found.  Try passing init= option to kernel.
Seams I have a number of problems. One is ramdisk error
and seccond is mising init.
I checked init and found it in /sbin/init, is it Ok?

Are there any ready to use images for eldk && 2.4.18?
Probaly someone has script for copying minimum files set from nfs rootfs to ramdisk.
What is the minimum set of files I need to boot?

I'm new in embedded linux field so excuse me for
such newbie questions.

Thank you for your help.
Best Regards. Xol.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
