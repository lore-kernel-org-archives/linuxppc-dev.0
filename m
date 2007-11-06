Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F15E7DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 21:37:24 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IpLo9-0000kZ-Fh
	for linuxppc-embedded@ozlabs.org; Tue, 06 Nov 2007 02:37:21 -0800
Message-ID: <13604112.post@talk.nabble.com>
Date: Tue, 6 Nov 2007 02:37:21 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: While booting montavista kernel for PPC sometimes Kernel Panic occurs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all...
Please find the print message when kernel panic occured while booting the
Montavista kernel for PPC. This happens rarely and i am not able to find th=
e
real cause of it ....
Please do suggest me how to debug it and the cause of it .
=20

################################################################
Hit any key to stop autoboot:  0
## Booting image at fc000000 ...
   Image Name:   Linux-2.6.10_mvl401-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1214112 Bytes =3D  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.10_mvl401-8272ads (root@localhost.localdomain) (gcc
version 3.4.3 (MontaVista 3.4.3-25.0.70.057
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.178.110:/home/filesys/svn/target ip=3D192.168.178.89:192.=
168f
PID hash table entries: 1024 (order: 10, 16384 bytes)
hr_time_init: arch_to_nsec =3D 83886080, nsec_to_arch =3D 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126976k available (2144k kernel code, 544k data, 156k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
mpc8272ads: Init
Registering platform device 'fsl-cpm-fcc.1'. Parent at platform
Registering platform device 'fsl-cpm-fcc.2'. Parent at platform
Registering platform device 'fsl-bb-mdio.0'. Parent at platform
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq =3D 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq =3D 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
elevator: using anticipatory as default io scheduler
nbd: registered device at major 43
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
hda: SanDisk SDCFB-1024, CFA DISK drive
hdb: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
hdb: probing with STATUS(0x51) instead of ALTSTATUS(0x0a)
ide0 at 0xf8000000-0xf8000007,0xf800002c on irq 5
hda: attached ide-default driver.
hda: attached ide-disk driver.
hda: max request size: 128KiB
hda: 2001888 sectors (1024 MB) w/1KiB Cache, CHS=3D1986/16/63
 /dev/ide/host0/bus0/target0/lun0: p1
physmap flash device: 4000000 at fc000000
Number of erase regions: 1
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum:  2.7 V
Vcc Maximum:  3.6 V
No Vpp line
Typical byte/word write timeout: 128 =C2=B5s
Maximum byte/word write timeout: 1024 =C2=B5s
Typical full buffer write timeout: 128 =C2=B5s
Maximum full buffer write timeout: 4096 =C2=B5s
Typical block erase timeout: 1024 ms
Maximum block erase timeout: 16384 ms
Chip erase not supported
 cfip->DevSize=3D0x1a
 cfip->DevSize=3D0x19
Device size: 0x2000000 bytes (32 MiB)
Flash Device Interface description: 0x0002
  - supports x8 and x16 via BYTE# with asynchronous interface
Max. bytes in buffer write: 0x20
Number of Erase Block Regions: 1
  Erase Region #0: BlockSize 0x20000 bytes, 512 blocks
phys_mapped_flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
cfi->cfiq->DevSize=3D0x19
number of CFI chips: 1
 ersize=3D0x40000
 ersize=3D0x40000
 ernum=3D0x100
offset=3D0x4000000
devsize=3D0x4000000
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Using physmap partition definition
Creating 7 MTD partitions on "phys_mapped_flash":
0x00000000-0x00200000 : "Kernel 1"
0x00200000-0x00400000 : "Kernel 2"
0x00400000-0x00c00000 : "Application 1"
0x00c00000-0x01400000 : "Application 2"
0x02900000-0x03d00000 : "JFFS2 FS"
0x03f00000-0x03f40000 : "U-BOOT"
0x03f40000-0x03f80000 : "bootloader env"
fip->fc_clockmask 0x0ff000000
fip->fc_clockroute 0x02e000000
The immap->im_cpmux.cmx_fcr value is 2e000000
The immap->im_cpmux.cmx_fcr value is 2e000000
eth0: FCC ENET Version for Cashel Board, 00:90:45:e0:ab:dc
fip->fc_clockmask 0x0ff0000
fip->fc_clockroute 0x02c0000
The immap->im_cpmux.cmx_fcr value is 2e2c0000
The immap->im_cpmux.cmx_fcr value is 2e2c0000
eth1: FCC ENET Version for Cashel Board, 00:90:45:60:ab:dc
NET: Registered protocol family 2
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C0173540 LR: C015CB58 SP: C7C29DD0 REGS: c7c29d20 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 20000000
TASK =3D c7c10ab0[1] 'swapper' THREAD: c7c28000
Last syscall: 120
GPR00: 00000001 C7C29DD0 C7C10AB0 C7C275C0 C7C92000 C026D8D4 C7EB0C15
C02A4598
GPR08: 0000001E C02B993C C7C28000 00000000 07C10C80 1001A108 07FFD000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 07FF87E4 00000000 00000002
07BC5680
GPR24: C0270000 FFFB78A9 C02B9708 C7C92000 C02A0000 C7C275C0 C7C275C0
C7C275C0
Call backtrace: c015cb58  c015cc74  c015cdf8  c001a020  c001a0e8  c001a18c=
=20
c001a258  c00054e0  c000469c  c0299f
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..
################################################################

Hoping for a reply from your side soon=20

-----Misbah <><
--=20
View this message in context: http://www.nabble.com/While-booting-montavist=
a-kernel-for-PPC-sometimes-Kernel-Panic-occurs-tf4757236.html#a13604112
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
