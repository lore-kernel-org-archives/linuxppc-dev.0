Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D84FA67A65
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2005 23:44:41 +1100 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.3/8.13.2) id j23CiZSb026267
	for linuxppc-dev@ozlabs.org; Thu, 3 Mar 2005 13:44:35 +0100
Date: Thu, 3 Mar 2005 13:44:35 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050303124435.GA24233@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Subject: Re: GCC4 fun.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I just booted a self-compiled 2.6.11 on my iBook G4.

The dmesg shows a hickup, where I am wondering what's the cause.

Total memory =3D 768MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.11 (root@whisker) (gcc version 3.3.5 (Debian 1:3.3.5-8)) =
#29 Wed Mar 2 20:15:15 CET 2005
Found UniNorth memory controller & host bridge, revision: 210
Mapped at 0xfdf00000
Found a Intrepid mac-io controller, rev: 0, mapped at 0xfde80000
Processor NAP mode on idle enabled.
PowerMac motherboard: iBook G4
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
On node 0 totalpages: 196608
  DMA zone: 196608 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=3D/dev/hda5 ro=20
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc633000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
time_init: decrementer frequency =3D 18.432000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773632k available (1928k kernel code, 1044k data, 144k init, 0k hig=
hmem)
AGP special page: 0xeffff000
Calibrating delay loop... 663.55 BogoMIPS (lpj=3D331776)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
scheduling while atomic: swapper/0x00000002/0
Call trace:
 [c0007620] dump_stack+0x18/0x28
 [c01de704] schedule+0x678/0x67c
 [c0004500] syscall_exit_work+0x108/0x10c
 [c02a97b4] proc_root_init+0x168/0x174
 [ff847288] 0xff847288
 [c02945e8] start_kernel+0x144/0x170
 [00003a30] 0x3a30

Anyone an idea where this comes from? (Or, what else is needed for a
qualified statement about it?)

TIA,

Joerg

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJwazjY4+4PdzvOARAuVFAJ97RbjoN4Nj4n7mBSKFY2DIcor4dQCfUh2t
6zoWr3a4gT15WnemoS4tBGU=
=hmKL
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
