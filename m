Message-ID: <000c01c2167c$162a4560$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Uart problem of Linux 2.4.18
Date: Tue, 18 Jun 2002 11:56:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,everyone,
     I want to run linux in my fads860T board.but i find when concole printf
"CPM UART version 3.00" then it stop it ,it seems the system dead!
 I use linux version is 2.4.18.Console is SMC2,disable copy back mode,
 Can you give me some advice? thank you in advance!



=>bootm 500000
## Booting image at 00500000 ...
   Image Name:   2.4.4.
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    654829 Bytes = 639 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.19-pre10 (root@gaof.guoguang.com.cn) (gcc version 2.95.2 19991
024 (release)) #1 Fri Jun 14 16:45:56 CST 2002
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 6456k available (1200k kernel code, 380k data, 48k init, 0k highmem)
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
CPM

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
