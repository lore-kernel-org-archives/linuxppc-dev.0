Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1D45CDDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 03:15:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Refactor booting-without-of.txt
Date: Tue, 16 Oct 2007 10:13:59 -0700
In-Reply-To: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
Message-Id: <20071016171417.64605230209@mail24-fra.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On a similar note, is there interest in actually factoring the device
tree code out from the different architectures into a common codebase?

Steve=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@o
zlabs.org] On Behalf Of Grant Likely
> Sent: Monday, October 15, 2007 9:09 AM
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
> Thoughts?
> g.
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
