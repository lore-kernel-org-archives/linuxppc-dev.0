Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4744BDDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 01:48:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2LEmhCH004675
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 07:48:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2LEmh9F029103
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:48:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 06/17] Document the linux,network-index property.
Date: Wed, 21 Mar 2007 07:48:42 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
In-Reply-To: <36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Wood Scott-B07421" <scottwood@freescale.com>
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
> Sent: Wednesday, March 21, 2007 8:31 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 06/17] Document the linux,network-index property.
>=20
> > To allow more robust association of each network device node with an
> > index (such as is used by the firmware or an EEPROM to indicate MAC
> > addresses), a network device's node may specify the index=20
> explicitly.
>=20
> > +   - linux,network-index : This is the intended "index" of this
> > +     network device.  This is used by the bootwrapper to interpret
> > +     MAC addresses passed by the firmware when no information other
> > +     than indices is available to associate an address=20
> with a device.
>=20
> What a nasty thing, and quite a misnomer too.  Linux
> _already_ knows how to bind ethN to which device, based
> on user preferences; what you are really after is a way
> to label the several network devices in your device tree
> for use by firmware.
>=20
> There already is a completely generic such mechanism; it's
> called "aliases".
>=20
> And yes I still believe the flattened dev tree should
> implement the "/aliases" node and drop the other alias
> mechanism, the OF-defined way is so much more flexible.
> It even shows up in /proc/device-tree :-)

Segher, what is the the 'other alias' mechanism you are referring
to that should be dropped?  Is it this proposed linux,network-index
property?  or something else?

Stuart
