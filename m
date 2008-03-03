Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B67ACDDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 06:54:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx PowerPC
Date: Mon, 3 Mar 2008 11:53:18 -0800
In-Reply-To: <47CAF0FC.70706@seznam.cz>
References: <47BD212B.6090809@dlasys.net>
	<20080221175025.7817BBD8057@mail91-sin.bigfish.com>
	<47CAF0FC.70706@seznam.cz>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <monstr@seznam.cz>
Message-Id: <20080303195322.DC3AD1BE006F@mail32-sin.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Michel,

I've had it on my todo list to get the u-boot stuff working for powerpc
too...  However, I remember a brief comment from John Williams that
you'd separated the BSP generation process more.  Details (or better
yet, code and patches) would be appreciated, here, since I'm a bit
swamped at the moment.

Steve

> -----Original Message-----
> From: Michal Simek [mailto:monstr@seznam.cz]
> Sent: Sunday, March 02, 2008 10:25 AM
> To: Stephen Neuendorffer
> Cc: David H. Lynch Jr.; Grant Likely; linuxppc-embedded
> Subject: Re: Xilinx PowerPC
>=20
> Hi All,
>=20
> > http://git.xilinx.com/gen-mhs-devtree.git contains two utilities for
> > generating device trees from EDK projects.  The older option is a
python
> > script, originally written by Grant.  The newer (and probably more
> > mature at this point) option is an EDK BSP generator for u-boot,
> > originally written by Michal Simek.  Preferably this gets passed
from a
> > uboot, although it's also possible to compile it into the kernel.
> > Currently, the uboot option is somewhat annoying because there's not
a
> > good surefire way for getting uboot up and running on an EDK design.
> > (Unfortunately, the EDK BSP generator is incomplete, and the uboot
> > support for virtex needs some work to get it integrated as well).
>=20
> U-BOOT part will be removed from EDK generator. The new name will be
only
> fdt_v1.00.a. I have prepared separated version for FDT generation and
for U-BOOT
> generation.
>=20
> Steve: You can remove U-BOOT part from generator. This part is useful
only for
> Microblaze cpu.
>=20
> Regards,
> Michal Simek
