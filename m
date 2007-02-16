Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 812D6DDE35
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:58:14 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1GGwBrc007877
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:58:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1GGwAHM010074
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 10:58:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: purpose of /chosen node (was RE: [PATCH] powerpc: deleteboot-cpu
	and chosen nodes from all DTSfiles)
Date: Fri, 16 Feb 2007 09:58:10 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BEA4@az33exm25.fsl.freescale.net>
In-Reply-To: <1171584519.5644.60.camel@localhost.localdomain>
References: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<20070215230134.GB21654@localhost.localdomain>
	<1171584519.5644.60.camel@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
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
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Thursday, February 15, 2007 6:09 PM
> To: David Gibson
> Cc: Yoder Stuart-B08248; Segher Boessenkool; linuxppc-dev@ozlabs.org
> Subject: Re: purpose of /chosen node (was RE: [PATCH]=20
> powerpc: deleteboot-cpu and chosen nodes from all DTSfiles)
>=20
>=20
> > You're right.  Question is, can we change it now.  It's out there in
> > the documentation, on the other hand, I don't think the kernel
> > actually uses it anywhere yet.  BenH, opinion?
>=20
> We can change the documentation and add a little note about "obsoleted
> practice". I don't think the kernel uses it.
>=20

I'll submit a patch to booting-without-of.txt for this.

Stuart
