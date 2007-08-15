Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9D370DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 02:14:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device Tree tool [was RE: [PATCH] Consolidate
	XILINX_VIRTEXboardsupport]
Date: Wed, 15 Aug 2007 09:14:27 -0700
In-Reply-To: <2934.5453-20654-824518122-1187160093@seznam.cz>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Michal Simek" <Monstr@seznam.cz>
Message-Id: <20070815161429.17C80EF8057@mail82-blu.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't have an EDK script.  I'm currently using a hacked version of=20
Grant's gen_mhs_devtree.py script, and then I modified the resulting
device
tree in an effort to get things working.  In the long term, I think
having
an EDK script will be necessary to ensure that all of the information is
in the device tree.

Michal: what do you need from me?

Steve

> -----Original Message-----
> From: Michal Simek [mailto:Monstr@seznam.cz]=20
> Sent: Tuesday, August 14, 2007 11:42 PM
> To: Stephen Neuendorffer
> Cc: Grant Likely; microblaze-uclinux@itee.uq.edu.au;=20
> linuxppc-embedded@ozlabs.org
> Subject: RE: Device Tree tool [was RE: [PATCH] Consolidate=20
> XILINX_VIRTEXboardsupport]
>=20
> Hi,
>=20
> >I've managed to get the first step working: a microblaze system
> >advertising of_devices in 2.6 using a flat device tree. =20
>=20
> It's great news.
>=20
> >Is there a concensus on how microblaze systems should get booted?
> >Currently,
> >I'm linking the device tree directly into the kernel itself,=20
> loading the
> >whole
> >mess using SystemAce and the start address jumps directly into the
> >kernel, which
> >is quite a bit different than the way powerpc works.  It's certainly
> >simpler:
> >maybe too simple.  At the same time, replicating
> >the complexity of arch/powerpc with separate boot code may=20
> or may not be
> >worth it...
> >Any thoughts?
>=20
> Microblaze can be boot via U-BOOT. U-BOOT supports FDT for=20
> some PowerPC boards.
> I would like to help with this part of bootloader code.=20
>=20
> Do you have any EDK script for generation FDT?=20
>=20
> Best regards,
> Michal Simek
>=20
>=20
