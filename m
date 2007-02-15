Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 23F54DDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:49:29 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1FHnOcO017311
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:49:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FHnOUY015439
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:49:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 10:49:23 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BB39@az33exm25.fsl.freescale.net>
In-Reply-To: <2BDA6214-F867-4719-B0F6-E3409FB525F7@kernel.crashing.org>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<2BDA6214-F867-4719-B0F6-E3409FB525F7@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Jon Loeliger" <jdl@jdl.com>
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
> On Behalf Of Kumar Gala
[snip]
> > New syntax d#, b#, o# and h# allow for an explicit prefix
> > on cell values to specify their base.  Eg: <d# 123>
> >
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >
> > ---
>=20
> What are people's thoughts on supporting '0x' and '0X' for hex?

Are you saying allow d#1234, h#5678, and 0x5678?  Or use 0x instead
of h#?

Stuart
