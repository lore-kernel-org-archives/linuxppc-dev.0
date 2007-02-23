Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8EFBBDDEB9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 06:15:36 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1NJFWJn028711
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 12:15:32 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1NJFVBb012282
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 13:15:31 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 12:15:30 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
In-Reply-To: <259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net><A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org><20070222011811.GA18364@localhost.localdomain><45b623f395654fc4f4920b9553794def@kernel.crashing.org><20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'd rather write it like
>=20
> >       interrupts        =3D < a 4   b 4   0 4   1 4   2 4 >
> >       interrupt-parents =3D <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>
>=20

Segher, with your proposal here of an interrupt-parents property
is this really keeping with the normal OF way of representing
property values?

Examples exists where one property tells you how to interpret
or decode another (e.g. #address-cells), but your proposal we
have two distinct properties each with values that together
provide the complete 'value' (interrupt parent + interrupt
specifier).  Is there any precedent for this approach?

I think I'd rather see all the information encoded in
one value.

Stuart
