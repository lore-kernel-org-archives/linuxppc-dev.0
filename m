Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C23345C.1274D300@multitech.co.in>
Date: Fri, 21 Dec 2001 18:38:44 +0530
From: srinivas pulipati <srinivasp@multitech.co.in>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel panic: Attempted to kill init!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,

i am trying to boot the mpc860 board with ramdisk support.
i downloaded pre built ramdisk.image.gz from
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz

i put a printk in fs/opennamei () function
i end up with the following output.

is it crashing because of library missing or something else?

thanks in advance - srinivas


loaded at:     00200000 0020B598
relocated to:  00180000 0018B598
board data at: 001801D8 0018020C
relocated to:  001F0100 001F0134
zimage at:     00208000 00249B2F
initrd at:     00249B2F 002D5831
avail ram:     002D6000 00800000

Linux/PPC load: console=ttyS0,38400 root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.9 (pulipati@pulipati) (gcc version 2.95.2 19991024
(release)) #2 Fri Dec 21 18:19:15 IST 2001
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,38400 root=/dev/ram
Decrementer Frequency = 150000000/60
Calibrating delay loop... 39.73 BogoMIPS
Memory: 6688k available (520k kernel code, 216k data, 32k init, 0k
highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
Serial driver version 5.05c (2001-07-08) with no serial options enabled
block: 64 slots per queue, batch=8
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 559k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 32k init
open_namei(): trying to open /dev/console
open_namei(): trying to open /etc/ld.so.preload
open_namei(): trying to open /etc/ld.so.cache
open_namei(): trying to open /lib/libtermcap.so.2
open_namei(): trying to open /lib/libc.so.6
open_namei(): trying to open /etc/nsswitch.conf
open_namei(): trying to open /lib/libnss_compat.so.1
open_namei(): trying to open /usr/lib/libnss_compat.so.1
open_namei(): trying to open /lib/libnss_files.so.1
open_namei(): trying to open /usr/lib/libnss_files.so.1
Kernel panic: Attempted to kill init!
Rebooting in 60 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
