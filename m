Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 69D6467B6A
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 19:57:47 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8Q9veXD012771
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 02:57:40 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8Q9vcaG025775
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 04:57:39 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] QE device tree node definition
Date: Tue, 26 Sep 2006 17:57:37 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C429@zch01exm21.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D19D680@zch01exm20.fsl.freescale.net>
From: "Li Tony-r64360" <Tony.Li@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Li Yang-r58472=20
> Sent: Tuesday, September 26, 2006 2:24 PM
> To: Li Tony-r64360; linuxppc-dev@ozlabs.org
> Subject: RE: [RFC][PATCH] QE device tree node definition
>=20
> > -----Original Message-----
> > From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> >=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf=20
> > Of Li Tony-r64360
> > Sent: Tuesday, September 26, 2006 10:40 AM
> > To: linuxppc-dev@ozlabs.org
> > Subject: RE: [RFC][PATCH] QE device tree node definition
> >=20
> >=20
> > 1) Where is the QE embedded interrupt controller ?
> > I think the interrupt-parent of the QE function should point to it.
>=20
> QEIC is not necessarily to be defined specifically rather=20
> than using generic interrupt controller spec.
> >=20
> > 2) For the UCC, It is better to make rx-clock and tx-clock=20
> as required=20
> > properties.
> >  Almost all functions need this properties
>=20
> Almost is NOT enough to make them required properties for all=20
> UCC functions.  There are some devices uses TSA as clock source.

If using TSA, the xx-clock property can use some specific macro to
represent it.
All the UCC need a general clock whether from clocks or TSA.=20

>=20
> - Leo
>=20
