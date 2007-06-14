Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71A91DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:53:29 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5EFrN1T012705
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:53:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5EFrNiJ015518
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 10:53:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 08:53:20 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302F335E6@az33exm25.fsl.freescale.net>
In-Reply-To: <480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
References: <20070612181825.730300780@am.sony.com>><466EEC01.6080807@am.sony.com><f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org><20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com><20070613181854.GA723@aepfle.de><1181774801.14818.343.camel@localhost.localdomain><590cd31b74053f7499c1f53a29639175@kernel.crashing.org><9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
	<480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
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
> Sent: Thursday, June 14, 2007 10:36 AM
> To: Yoder Stuart-B08248
> Cc: linuxppc-dev@ozlabs.org; Olaf Hering; paulus@samba.org
> Subject: Re: [patch 29/30] PS3: Device tree source.
>=20
> >> "compatible" is only needed if your "name" is bogus, or your
> >> machine _actually_ is 100% compatible to some other machine.
> >
> > Segher,
> >
> > I don't understand this if we are following the 'Generic Names'
> > recommendation (which I thought we were).
>=20
> Yes, we should follow that recommended practice.
>=20
> > Guideline 1: "name" property values must be generic, reflecting
> > the device's function, but not necessarily its precise programming
> > model.
>=20
> Yes -- a short clear name that makes device tree paths
> easily readable (and easy to type ;-) ) for human beings.
>=20
> > Guideline 2: The "compatible" property must be present.
>=20
> ...if "name" doesn't perform the same function yet, which
> of course is almost always.

But the recommended practice doesn't have an "...if".  It says
"compatible" must always be present.

The reason an OS would need to support "name" as well as=20
"compatbile" for device driver matching would be
for _legacy_ device trees that don't follow the recommended
practice.

For newly developed trees "compatible" should specify the programming
model, if we are following that recommended practice.

So bottom line is that we shouldn't be moving toward using "name"
to specify the programming model.

[snip]

>=20
> Since anything that matches for "compatible" entries
> also first should check the "name" contents, it should
> be okay for flat device trees to have the information
> that could/should be in "name" in "compatible", instead.

As mentioned above, matching on "name" would seem to be
needed to handle legacy device trees as I read some of
the reasoning in the generic names recommended practice.
Not sure if that applies to Linux or not...=20

Stuart
