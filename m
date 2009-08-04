Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3E5EBB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 17:23:59 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 0B1CADDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 17:23:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Kernel fault with simple UIO interrupt driver in 2.6.30.4
Date: Tue, 4 Aug 2009 09:23:54 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849DFCA3D@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Oh okay, I didnt think anybody would need it :)



=3D> bootm 2000000 - 3000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.30.4
   Created:      2009-08-04   7:06:18 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    3978238 Bytes =3D  3.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x3000000
Using MPC831x RDB machine description
Linux version 2.6.30.4 (root@vmlinux) (gcc version 4.0.0 (DENX ELDK 4.1 =
4.0.0)) #25 Tue Aug 4 09:05:58 CEST 2009
console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
32512
Kernel command line: BOOTLOADER_VER=3DMCU_bl_BPT_1.0.4
NR_IRQS:512
IPIC (128 IRQ sources) at fdffd700
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[7800001] shift[22] registered
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 123888k/131072k available (5560k kernel code, 7020k reserved, =
184k data, 93k bss, 2476k init)
Kernel virtual memory layout:
  * 0xffffe000..0xfffff000  : fixmap
  * 0xfdffc000..0xfe000000  : early ioremap
  * 0xc9000000..0xfdffc000  : vmalloc & ioremap
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1
Calibrating delay loop... 66.56 BogoMIPS (lpj=3D133120)
Mount-cache hash table entries: 512
net_namespace: 716 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
Freescale PowerQUICC MII Bus: probed
Freescale PowerQUICC MII Bus: probed
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 242
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 17) is a 16550A
brd: module loaded
loop: module loaded
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ef:23:33
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:7e:21
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
Fixed MDIO Bus: probed
IRQ 20/IRQ3 Kernel Driver: IRQF_DISABLED is not guaranteed on shared =
IRQs
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
NIP: 00000000 LR: c004755c CTR: 00000000
REGS: c7827d50 TRAP: 0400   Not tainted  (2.6.30.4)
MSR: 20001032 <ME,IR,DR>  CR: 28000022  XER: 20000000
TASK =3D c7828000[1] 'swapper' THREAD: c7826000
GPR00: 00000002 c7827e00 c7828000 00000014 00000002 00000014 c73adb7c =
c06bb460
GPR08: 00000000 00000000 00000014 00000000 00000000 00000000 07fff000 =
00000001
GPR16: ffffffff 00000000 007fff00 07ff9794 00000000 00000000 007ffeb0 =
00000000
GPR24: c73ad180 c02d70a4 c0574f28 00009032 00000014 00000000 c73adb40 =
c0574f08
Call Trace:
[c7827e00] [c00474e4] 0xc00474e4 (unreliable)
[c7827e20] [c0047754] 0xc0047754
[c7827e50] [c019c568] 0xc019c568
[c7827e90] [c019c7f8] 0xc019c7f8
[c7827ea0] [c0177a80] 0xc0177a80
[c7827ec0] [c0177b94] 0xc0177b94
[c7827ee0] [c01764d8] 0xc01764d8
[c7827f10] [c0177590] 0xc0177590
[c7827f20] [c017703c] 0xc017703c
[c7827f40] [c0178080] 0xc0178080
[c7827f60] [c0319884] 0xc0319884
[c7827f70] [c00038dc] 0xc00038dc
[c7827fe0] [c03037c0] 0xc03037c0
[c7827ff0] [c0010778] 0xc0010778
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 747097271ea314a9 ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

=20
=20
=20
=09
		=20
=20

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:             +49 731 88 00 71 58
Fax:                 +49 731 88 00 71 99
Email:              frank.prepelica@ubidyne.com
Homepage:       www.ubidyne.com
=20
Registered office: Ulm
District court of Ulm: HRB 5295
Managing Directors:
Dipl. Ing. Ken Hawk
Dipl. Ing. Beat M=FCller
Dipl. Ing. Mike Levis

> -----Urspr=FCngliche Nachricht-----
> Von: Michael Ellerman [mailto:michael@ellerman.id.au]
> Gesendet: Dienstag, 4. August 2009 04:31
> An: Frank Prepelica
> Cc: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel fault with simple UIO interrupt driver in 2.6.30.4
>=20
> On Mon, 2009-08-03 at 15:07 +0200, Frank Prepelica wrote:
> > Hi all,
> >
> > due to a new revision of our custimized board, i need to port our
> current kernel (2.6.24)
> > to the latest kernel version 2.6.30.4.
> >
> > Among other things the UIO interrupt driver makes some trouble. The
> driver runs
> > smoothly on 2.6.24 but I'll get kernel faults when running in =
2.6.30.4.
>=20
> You seem to have forgotten to post the log of the oops :)
>=20
> cheers
