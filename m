Message-Id: <200108231432.KAA09949@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCSI PMC card
Date: Thu, 23 Aug 2001 10:24:56 -0400
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to put a Cyclone SCSI PMC (symbios 53c895 chipset) card on my
Motorola MVME2400 and I see some wierd stuff. If I put the SCSI card on a
SPAN card, the kernel comes up and see the card, but when I place the SCSI
card on either of the 2 PMC slots on the base, I hang while probing PCI
hardware. It gets part way through the PCI fixup resources section and just
hangs. Here is my boot
Linux/PPC load: console=ttyS0,9600 root=/dev/ram0
Uncompressing Linux...done.
Now booting the kernel
Total memory = 128MB; using 512kB for hash table (at c0200000)
Linux version 2.4.3 (bwaite@chicory.cspi.com) (gcc version 2.95.3 20010111
(pre1PReP architecture
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram0
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at fc000000
OpenPIC timer frequency is 12.500243 MHz
time_init: decrementer frequency = 24.999930 MHz
Calibrating delay loop... 699.59 BogoMIPS
Memory: 125080k available (984k kernel code, 496k data, 88k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.0, res_start: 3c000000->fc000000
Fixup mem res, dev: 0.d, res_start: 2ff7f000->eff7f000
Fixup mem res, dev: 0.e, res_start: 2ff7ec00->eff7ec00
Fixup mem res, dev: 0.e, res_start: fffc0000->bffc0000




A thing to note is that I do not have and SCSI support built into this
kernel. I built scsi_mod, sd_md, and sym53c8xx and load them as modules.
I am using the 2.4.3 kernel and I have tried building the sym module into the
driver, but the hangs occurs before the driver ever loads! Any idea what has
gone wrong while tring to probe this card? It is strage that it works fine on
a SPAN card. Too bad that is not a solution for us. PS this worked under 2.2
so I know the card is OK.

Thanks

Any help would be great thanks.
Brian
--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
