Message-ID: <20011206170849.66484.qmail@web21010.mail.yahoo.com>
Date: Thu, 6 Dec 2001 14:08:49 -0300 (ART)
From: =?iso-8859-1?q?Julio=20E?= <jeichem@yahoo.com.br>
Subject: Bug in dynamic linker
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm trying to boot linux on powerPC embedded system
(using FADS850SAR board), I've compiled busybox 0.51
and made a RAMDISK wich I downoaded to target (I'm
using ppcboot from denx), the linux starts booting and
then I got this massages:
Calibrating delay loop... 47.71 BogoMIPS
Memory: 6000k available (964k kernel code, 388k data,
40k init, 0k highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 2048 (order: 1, 8192
bytes)
Inode-cache hash table entries: 512 (order: 0, 4096
bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
block: queued sectors max/low 3901kB/1300kB, 64 slots
per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 40:00:00:00:00:00
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194302k freed
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: AppleTalk 0.18a for Linux NET4.0
VFS: Mounted root (ext2 filesystem).
BUG IN DYNAMIC LINKER ld.so: dl-minimal.c: 105:
realloc: Assertion `ptr == alloc_last_block' failed!
Standalone-shell terminated

Is there some bug in DYNAMIC LINKER for powerPC850 or
I'm doing something wrong? What can it be?
I'm using glibc:2.1.2 - binutils:2.9.5.0.22 - gcc
2.9.5

By the way, my libraries are located in
/linuxppc/CDK/lib on my PC and in /lib on the embedded
system I've made a software link on RAMDISK in
/linuxppc/CDK which points to /lib, the question is
why?

thanks in advice,

Jeich.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
