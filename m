Message-ID: <006c01c0650f$73b65d60$1e894b82@pc30>
From: "Nils Hagge" <Nils.Hagge@stud.uni-hannover.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel panic: No init found.  
Date: Wed, 13 Dec 2000 15:17:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I try to run Hard Hat Linux from Montavista as described in the CDK 1.2
manual on an RPX lite board.
Unfortunately, the installation procedure is only for hosts with Red Hat
Linux, I hoped this would work for SuSE, too.

The problem has to do with the NFS filesystem. I can successfully download a
precompiled
Hard Hat Linux boot-image via TFTP and monitor this with the serial port.

The following is the output over the serial port...

 target IP address : 824B8932
 target file name  : rpxlite.srec
 address bias      : 0
Starting tftp download:
inetARP(): OK
.1.2.4.8.16.32.64.128.256.512.1024.2048.4096.8192
load_tftp(): OK
1087283 data bytes, 13764 S-records, 2124 tftp blocks, 0 repeated blocks
start address = 00200000
load_tftp_toMem(): OK
Transferring control to downloaded program
loaded at:     00200000 0020B1FC
relocated to:  00180000 0018B1FC
board data at: 001801C8 001801E4
relocated to:  00200100 0020011C
zimage at:     00206000 0026A4C4
avail ram:     0026B000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=/opt/hardhat/devkit/ppc/8xx/target
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.14 (root@rodan.mvista.com) (gcc version 2.95.2 19991030
(2.95.
3 prerelease/franzo)) #1 Tue Aug 8 02:01:27 PDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=/opt/hardhat/devkit/ppc/8xx/target
time_init: decrementer frequency = 240000000/60
Calibrating delay loop... 63.69 BogoMIPS
Memory: 15152k available (740k kernel code, 456k data, 36k init)
[c0000000,c1000
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:10:ec:00:1b:fb
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 130.75.137.50, my address is 130.75.137.59
Looking up port of RPC 100003/2 on 130.75.137.50
Looking up port of RPC 100005/1 on 130.75.137.50
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 36k init
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

----snip----

The filesystem seems to be mounted, but it does not find any files in there
although the full "linux tree" is available. I also tried adding
  init=/bin/init   init=bin/init    init=/opt/.../target/bin/init
to the boot arguments, but nothing helped.

Do you know that problem or have an idea? Any help is welcome. Thank in
advance.

Nils Hagge


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
