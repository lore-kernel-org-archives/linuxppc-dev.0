Message-ID: <5D2136DF3DD5D311AE89009027C67FB003138BA8@fmsmsx96.fm.intel.com>
From: "Zheng, Haifei" <haifei.zheng@intel.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'greyham@research.canon.com.au'" <greyham@research.canon.com.au>
Subject: initrd problems on CLLF860T, please help.
Date: Wed, 14 Feb 2001 11:00:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

We are trying to boot our CLLF860T board with an initrd. We are using Monta
Vista Hard Hat (kernel 2.2.14) and we built out own ramdisk image. ( I know
there is an example ramdisk.image.gz from Hard Hat but haven't found it) and
we are getting the following boot messages:

Load menu: press 123456789T key : <?> : T
 target IP address : 0A14140A
 target file name  : current-initrd
 address bias      : 0
Starting tftp download:
inetARP(): OK
.1.2.4.8.16.32.64.128.256.512.1024.2048.4096.8192.16384
load_tftp(): OK
1359955 data bytes, 17216 S-records, 2657 tftp blocks, 0 repeated blocks
start address = 00200000
load_tftp_toMem(): OK
Transferring control to downloaded program
loaded at:     00200000 0020C580
relocated to:  00180000 0018C580
board data at: 001801C8 001801E4
relocated to:  00200100 0020011C
zimage at:     00207000 0026CB2E
initrd at:     0026CB2E 00285258
avail ram:     00286000 01000000

Linux/PPC load: root=/dev/ram
misc.c
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.14 (root@shark) (gcc version 2.95.2 19991030 (2.95.3
prereleas
e/franzo)) #541 Wed Feb 14 09:57:22 PST 2001
m8xx_setup.c:92: Boot arguments: root=/dev/ram
initrd memory block starts: c026cb2e ends c0285258
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 15028k available (748k kernel code, 464k data, 40k init)
[c0000000,c1000
000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:10:ec:00:1a:0f
CONFIG_RPXCLASSIC
The FEC Ethernet specific entries in the device structure...
eth1: FEC ENET Version 0.2, 00:10:ec:80:1a:0f
fec: Phy @ 0x0, type LXT971 (0x001378e2)
fec: link up, 100 Mbps, full-duplex, auto complete
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.20.20.10, my address is 10.20.20.11
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem).
Freeing unused kernel memory: 40k int
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

Any help will be high appreciated.

Haifei


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
