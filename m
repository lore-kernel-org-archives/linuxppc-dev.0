Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F1C@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: VFS: Unable to mount root fs on 01:00 ... 
Date: Mon, 16 Dec 2002 13:01:46 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just got my 2.4 kernel running on my 860 board. However I have now
encountered a new problem "Kernel panic: VFS: Unable to mount root fs on
01:00".

There are lots of posts regarding this problem but no one "seems" to have
posted a solution and then claim afterwards that it works ... so I
regretfully must ask again ...

Here's some info about my setup:

1.)	ppcboot 1.1.6
2.)	bootargs  "root =/dev/ram rw"
3.)	CONFIG_BLK_DEV_LOOP=y
4.)	CONFIG_BLK_DEV_RAM=y
5.)	CONFIG_BLK_DEV_RAM_SIZE=4096
6.)	CONFIG_BLK_DEV_INITRD=y
7.)	Tftpboot ... downloads my kernel to 0x100000
8.)	setenv loadaddr 0x00200000
9.)	setenv bootfile simple-initrd
10.)	tftpboot ... down load init rd
11.)	imi 0x00100000 0x00200000 ... images are ok
12.)	bootm 0x00100000 0x00200000 ... kernel starts ...
13.)	Kernel panic: VFS: Unable to mount root fs on 01:00

Thanks for any help at all,
Jim

kdb->bi_busfreq = 40000000
## Loading RAMDisk Image at 00200000 ...
   Image Name:   Simple Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1459535 Bytes = 1425 kB = 1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x00200040 ... 0x0036458E (len=1459535=0x16454F)
   Loading Ramdisk to 00dda000, end 00f3e54f ... OK
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.20-pre8 (jgdon@gomba.ca) (gcc version 2.95.3 20010315
(release
)) #58 Mon Dec 16 09:33:30 EST 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Decrementer Frequency = 300000000/60
Calibrating delay loop... 79.66 BogoMIPS
Memory: 15352k available (572k kernel code, 220k data, 36k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
INFO<mount_block_root>:name = /dev/root ... fs_names = ext2
Kernel panic: VFS: Unable to mount root fs on 01:00
 <0>Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
