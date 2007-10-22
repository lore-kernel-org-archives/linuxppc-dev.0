Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F209DDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 04:07:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [microblaze-uclinux] Re: [microblaze-uclinux] RE: [PATCH v3]
	Device tree bindings for Xilinx devices
Date: Mon, 22 Oct 2007 11:06:58 -0700
In-Reply-To: <1300.2720-24480-247293449-1192847306@seznam.cz>
References: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
	<1300.2720-24480-247293449-1192847306@seznam.cz>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <microblaze-uclinux@itee.uq.edu.au>
Message-Id: <20071022180700.8B3938E0088@mail19-fra.bigfish.com>
Cc: Leonid <Leonid@a-k-a.net>, Wolfgang Reissnegger <wre@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: owner-microblaze-uclinux@itee.uq.edu.au=20
> [mailto:owner-microblaze-uclinux@itee.uq.edu.au] On Behalf Of=20
> Michal Simek
> Sent: Friday, October 19, 2007 7:28 PM
> To: microblaze-uclinux@itee.uq.edu.au
> Cc: Stephen Neuendorffer; Grant Likely; Leonid; Arnd=20
> Bergmann; linuxppc-dev@ozlabs.org; Wolfgang Reissnegger
> Subject: [microblaze-uclinux] Re: [microblaze-uclinux] RE:=20
> [PATCH v3] Device tree bindings for Xilinx devices
>=20
> Hi Steve and all,
> >Here's a full .dts generated using an updated version of
> >gen_mhs_devtree.py, following the proposal.
> >It happens to be a microblaze system, but you get the idea.
>=20
> I think that is no good idea generate dts with all information.
> Especially information about PVR - number 2 means - Full PVR=20
> and you can
> obtain information directly from PVR. It is waste of memory space.
> 			xilinx,pvr =3D <2>;

PowerPC does something with the powerpc equivalent of the PVR.
We should just do what they do...
=20
> In my opinion will be better generate only parameters which=20
> you want not all.
> That smells with unusable parameters.

In the long term, this may be true.  In the short term:
1) dtb size is not the key problem
2) making sure that everything works is a key problem.
3) The code that generates the dts should be as simple as possible,
so that we can easily document what it does.

In the long term, I'm all for optimizing the device tree that gets
built,
assuming that it appears to be a problem in real systems.

Steve
