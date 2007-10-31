Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A2D1DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:44:45 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9VFiasu014844
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:44:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9VFiapq010651
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 10:44:36 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Refactor booting-without-of.txt
Date: Wed, 31 Oct 2007 08:44:36 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2AD8@az33exm25.fsl.freescale.net>
In-Reply-To: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
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
> On Behalf Of Grant Likely
> Sent: Monday, October 15, 2007 11:09 AM
> To: linuxppc-dev; microblaze-uclinux@itee.uq.edu.au
> Subject: Refactor booting-without-of.txt
>=20
> Adding the Linux expected device tree bindings to
> booting-without-of.txt seems to be getting a little unwieldy.  Plus
> with more than one arch using the device tree (powerpc, sparc &
> microblaze) the device tree bindings aren't necessarily powerpc only
> (the Xilinx devices certainly fall in this category).
>=20
> Anyone have comments about splitting the expected device tree bindings
> out of booting-without-of.txt into a separate directory?
>=20
> Perhaps something like this; each file contains common bindings for
> the type of device and device specific properties:
>=20
> Documentation/of/
> Documentation/of/README - Description of the purpose and layout of
> this directory
> Documentation/of/net.txt - network device bindings (eth,=20
> MDIO, phy, etc)
> Documentation/of/serial.txt - serial device bindings
> Documentation/of/misc.txt - anything that doesn't fit=20
> anywhere else yet.
> Documentation/of/soc/* - System on chip stuff that doesn't fit will
> into established device types; possibly a separate file for each chip.
> Documentation/of/usb.txt - usb blah blah blah
> Documentation/of/whatever - you get the picture.
>=20

I agree in principle with what your are proposing.

One other thing to consider-- as has been publicly=20
announced in several forums, a committee in power.org
(including several folks on this thread) is working
on a standard called the ePAPR which in general is
attempting to standardize the base set of requirements
and boot conventions that apply to the flat device tree.
There will not be much device specific stuff to=20
start with.

The ePAPR document is actually quite far a long
and is well beyond the 'idea' stage.

The one point is that we hope that the device tree
with be useful for other embedded OSes beyond Linux.
So long term, I think this documentation should
be pulled out of the kernel source and put
on a public wiki that is not tied directly to Linux.
What you are proposing is a good start...

Stuart
