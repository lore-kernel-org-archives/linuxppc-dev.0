From: Tibor Pausz <pausz@stud.uni-frankfurt.de>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Adaptec 3940UW
Date: Tue, 16 Jan 2001 20:59:55 +0100
Message-Id: <19341211133139.30056@mail.server.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If have a trouble with my new Adaptec 3940UW card.
The card has two 7880 chips+Bridge chip
After the init of the card linux freezes

Linux 2.2.18 from kernel.org with UMAX S900 pci patch
(see thread: Status of PCI-PCI bridge on UMAX S900)

The boot output:

device tree used 23368 bytes
Total memory = 96MB; using 512kB for hash table (at c0200000)
Linux version 2.2.18 (tibor@callisto) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #5 Tue
 Jan 16 18:09:37 EST 2001
PCI buses 0..2 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at f2000000
pmac nvram is core99: 0
System has 32 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: off
via_calibrate_decr: decrementer_count = 112499 (674999 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 448.92 BogoMIPS
Memory: 94748k available (1204k kernel code, 2236k data, 116k init)
[c0000000,c6000000]
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 131072 bhash 65536)
NET4: AppleTalk 0.18 for Linux NET4.0
Initializing RT netlink socket
Starting kswapd v 1.5
MacOS display is /bandit/ATY,XCLAIM3DPro
Using unsupported 1152x870 ATY,XCLAIM3DPro at 81801400, depth=32, pitch=4608
Console: switching to colour frame buffer device 144x54
fb0: Open Firmware frame buffer device on /bandit/ATY,XCLAIM3DPro
ADB keyboard at 2, handler set to 3
ADB mouse at 3, handler 1
ADB mouse at 15, handler set to 4 (TurboMouse 5)
PowerMac Z8530 serial driver version 2.0
tty00 at 0xf3013020 (irq = 15) is a Z8530 ESCC, port = modem
tty01 at 0xf3013000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
Macintosh ADB mouse driver installed.
Macintosh non-volatile memory driver v1.0
DMA sound driver installed, using 4 buffers of 32k.
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
fd0: SWIM3 floppy controller
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
raid1 personality registered
(scsi0) <Adaptec AHA-394X Ultra SCSI host adapter> found at PCI 1/4/0
(scsi0) Wide Channel A, SCSI ID=7, 16/255 SCBs
(scsi0) Cables present (Int-50 NO, Int-68 NO, Ext-68 NO)
(scsi0) Downloading sequencer code... 422 instructions downloaded
(scsi1) <Adaptec AHA-394X Ultra SCSI host adapter> found at PCI 1/5/0
(scsi1) Wide Channel B, SCSI ID=7, 16/255 SCBs
(scsi1) Cables present (Int-50 NO, Int-68 NO, Ext-68 NO)
(scsi1) Downloading sequencer code... 422 instructions downloaded

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
