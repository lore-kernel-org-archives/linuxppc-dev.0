Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D37F8DDF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 00:39:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5EEd5Z5001816
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 07:39:05 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5EEd4jQ006046
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 09:39:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 07:39:03 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
In-Reply-To: <590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
References: <20070612181825.730300780@am.sony.com>
	><466EEC01.6080807@am.sony.com><f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org><20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com>
	<20070613181854.GA723@aepfle.de><1181774801.14818.343.camel@localhost.localdomain>
	<590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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
> Sent: Thursday, June 14, 2007 2:33 AM
> To: Benjamin Herrenschmidt
> Cc: linuxppc-dev@ozlabs.org; Olaf Hering; paulus@samba.org
> Subject: Re: [patch 29/30] PS3: Device tree source.
>=20
> > No name for the root of the DT.
>=20
> See my previous mail.
>=20
> > IMHO, model can be whatever he wants, I would say SonyPS3-XX or
> > something like that, whatever, doens't matter, the most precise the
> > better.
>=20
> It should be the model number of the machine.
>=20
> > Then you want compatible which is the really important one. sony,ps3
> > looks good to me for that, though you could have a list if=20
> you wanted.
>=20
> "compatible" is only needed if your "name" is bogus, or your
> machine _actually_ is 100% compatible to some other machine.

Segher,

I don't understand this if we are following the 'Generic Names'
recommendation (which I thought we were).

http://playground.sun.com/1275/practice/gnames/gnamv14a.html

It gives two guidelines:

Guideline 1: "name" property values must be generic, reflecting
the device's function, but not necessarily its precise programming
model.=20

Guideline 2: The "compatible" property must be present. Its first
component should be an explicit, unique name that identifies the
device precisely enough to be able to infer the detailed programming
model from that name. The format of that explicit name is
manufacturer,model,...

I read that and my understand is that _compatible_ is required
and specifies the precise programming model.  name is supposed
to be generic-- currently booting-without-of.txt says the
property is optional because the name can be inferred from
the node name which should be generic.

Stuart
