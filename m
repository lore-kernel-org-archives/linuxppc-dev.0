Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4B174DDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:10:59 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1FIAtP7027095
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:10:55 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FIAtnL024624
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:10:55 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 11:10:53 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BB59@az33exm25.fsl.freescale.net>
In-Reply-To: <E1HHkym-0005u5-HA@jdl.com>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
	<E1HHkym-0005u5-HA@jdl.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Jon Loeliger" <jdl@jdl.com>
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
> From: Jon Loeliger [mailto:jdl@jdl.com]=20
> Sent: Thursday, February 15, 2007 12:05 PM
> To: Yoder Stuart-B08248
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [DTC PATCH] Add support for decimal,octal and=20
> binary based cell values.=20
>=20
> So, like, the other day "Yoder Stuart-B08248" mumbled:
> >=20
> > I like to see no space between the d#, h#, etc and the
> > numeric value.
>=20
> So, that's one of the really nice things about parsers.
> Just do this, then:
>=20
>     d23 =3D <d#23>;		// Just like <d# 23>!
>=20
> The real question, though, is this:  MUST the space between
> 'd#' and '23' be removed so that it is all one token?

As long as the space is not required, it's cool.

Stuart
