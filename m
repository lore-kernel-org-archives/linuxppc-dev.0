Return-Path: <tmk@cmcltd.com>
Received: from cmcdns1.cmcltd.com (navint.cmcltd.com [59.160.161.31])
	by ozlabs.org (Postfix) with ESMTP id 2312667B61
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 23:19:04 +1000 (EST)
From: Mohan Krishna T <tmk@cmcltd.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: =?UTF-8?Q?Unable_to_boot_linux_on_Xilinx_ML403_board?=
Date: Mon, 25 Sep 2006 18:28:34 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <mailman.0.1159188664.24974.linuxppc-embedded@ozlabs.org>
Message-ID: <smtp_4517D0DE_85A0_0002.eml@>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
            I am working on Xilinx ML403 board. I am trying to boot with
Linux 2.4. My hardware includes a UART16550 and EMAC (OPB Ethernet) in
scatter gather mode. When I boot the linux. It is coming up to the following
point and hanging indefinitely. I have pasted my booting sequence below:

----------------------------------------------------------------------------
---------
loaded at:     00400000 0076F1E4
board data at: 0076C13C 0076C154
relocated to:  00405638 00405650
zimage at:     00405C03 004AE1BF
initrd at:     004AF000 0076B17B
avail ram:     00770000 08000000

Linux/PPC load: console=3Dtty1 console=3DttyS0,9600 ip=3Doff =
root=3D/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-ml403 (mta=40xinmta20) (gcc version 3.3.1
(MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) =2378 Mon Sep 25 16:53:39 IST
2006
Xilinx Virtex-II Pro and Virtex-4 port (C) 2002-2004 MontaVista Software,
Inc. (source=40mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3Dtty1 console=3DttyS0,9600 ip=3Doff =
root=3D/dev/ram rw
Xilinx INTC =230 at 0x41200000 mapped to 0xFDFFE000
Calibrating delay loop... 199.88 BogoMIPS
Memory: 125080k available (1188k kernel code, 396k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch=40atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq =3D 29) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: using sgDMA mode.
eth0: No PHY detected.  Assuming a PHY at address 0.
eth0: Xilinx EMAC =230 at 0x40C00000 mapped to 0xCA00D000, irq=3D31
eth0: id 2.0l; block id 11, type 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
----------------------------------------------------------------------------
----------

Thanks in advance..

Regards
Mohan Krishna



DISCLAIMER

=E2=80=9CThe information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information. If =
you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited. If you =
have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message and =
any attachments. Thank you=22=
