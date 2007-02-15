Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6360ADDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:00:26 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1FI0MuN027572
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:00:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FI0MLT022044
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:00:22 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 11:00:21 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BB49@az33exm25.fsl.freescale.net>
In-Reply-To: <20070215180008.GA25247@lixom.net>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
	<20070215180008.GA25247@lixom.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Olof Johansson" <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
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
> From: Olof Johansson [mailto:olof@lixom.net]=20
> Sent: Thursday, February 15, 2007 12:00 PM
> To: Yoder Stuart-B08248
> Cc: Jon Loeliger; linuxppc-dev@ozlabs.org
> Subject: Re: [DTC PATCH] Add support for decimal, octal and=20
> binary based cell values.
>=20
> On Thu, Feb 15, 2007 at 10:45:54AM -0700, Yoder Stuart-B08248 wrote:
> >=20
> > I like to see no space between the d#, h#, etc and the
> > numeric value.
> >=20
> > Does anyone see a good reason to keep whitespace there?
>=20
> Does it really matter what color the bike shed is?

In this case I think it does matter (a little :)).  If
you represent a number as <#h5678> it's clear that the
#h and 5678 are related.

If you represent it as <#h 5678> the relation between
the two is not as clear-- of course once you read the=20
spec you figure it out.

It's not a huge deal, but while we're adding a feature
to dtc why not make the syntax as clear as we can?

Stuart
