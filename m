Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9C1EB679FC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:54:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7I7DSk7014726
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 01:13:28 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7I5sn8q021384
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 00:54:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
Date: Fri, 18 Aug 2006 13:54:47 +0800
Message-ID: <2176B872C0407E44887F07CCAA8692930F6005@zch01exm21.fsl.freescale.net>
In-Reply-To: <1155866388.5803.10.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is it a good idea? Why we can not endure the "linux,phandle =3D <4d0>" =
in
i8259 node? And besides, this node was already referenced by the other
entries.

Using "&/soc8641@f8000000/pci@8000/i8259@4d0" or label seems so verbose
and weird.

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Benjamin Herrenschmidt
> Sent: Friday, August 18, 2006 10:00 AM
> To: Mark A. Greer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Directly reference i8259@4d0 nodes in=20
> mpc8641_hpcn.dts.
>=20
> On Thu, 2006-08-17 at 17:43 -0700, Mark A. Greer wrote:
> > On Fri, Aug 18, 2006 at 10:09:21AM +1000, Benjamin=20
> Herrenschmidt wrote:
> > > On Thu, 2006-08-17 at 16:20 -0500, Jon Loeliger wrote:
> > > > Rather than using some hand-coded linux,phandle
> > > > node references, use DTC's direct node refs ability
> > > > and let it manage the phandle names instead.
> > >=20
> > > Not 100% sure here but can't we use a label and do &label=20
> rather than
> > > having to copy the full path every time ? Would make=20
> things easier :) If
> > > not, that's probably something to add to dtc...
> >=20
> > Isn't linux,phandle basically the label that you speak of, though?
> > IOW, you may be saying, "No, keep using the linux,phandle".
>=20
> No, more something like
>=20
> pic:
>   <pic_node>
>=20
> and later
>=20
> &pic
>=20
> > Just trying to clarify things although I'm not sure that I=20
> really am...  :)
> >=20
> > Mark
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
