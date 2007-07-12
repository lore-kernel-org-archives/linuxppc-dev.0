Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2946FDDE34
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:13:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6CFDkrs017786
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 08:13:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6CFDkOg027100
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 10:13:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH 6/8] Walnut DTS
Date: Thu, 12 Jul 2007 08:13:46 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
In-Reply-To: <4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com><1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
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
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Segher Boessenkool
> Sent: Wednesday, July 11, 2007 12:50 PM
> To: Josh Boyer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [RFC][PATCH 6/8] Walnut DTS
>=20
> > +	UIC0: interrupt-controller0 {
>=20
> Why not just "interrupt-controller"?
>=20
> > +		#address-cells =3D <0>;
> > +		#size-cells =3D <0>;
>=20
> No need for these.

Isn't a good practice to put #address-cells in interrupt controller
nodes?

If the device tree has an interrupt map defined the interrupt
parent 'unit interrupt specifier' has to be interpreted according
to the #address-cells of the interrupt parent.  It seems like=20
typical practice in the current DTS files to explicitly define this
in the interrupt controller.

Of course this particular device tree doesn't have an interrupt
map...

#size-cells is not needed.

Stuart
