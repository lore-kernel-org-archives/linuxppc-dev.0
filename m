Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7FE1DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 20:01:47 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8BA1fJW023315
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:01:42 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8BA1ekL015700
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:01:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Tue, 11 Sep 2007 18:01:39 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070910032529.GA27828@localhost.localdomain>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
>=20
> On Fri, Sep 07, 2007 at 04:43:35PM +0200, Segher Boessenkool wrote:
> > > +   l) Freescale DMA
> >=20
> > > +    - compatible : Should be "fsl,dma".
> >=20
> > Please choose some more specific name.  "fsl,mpc8540-dma" would
> > be a reasonable choice perhaps.
>=20
> More precisely, the compatible property should always have an specific
> entry based on the exact chip the DMA engine resides in, as well as a
> more general entry for any fsl dma engine of this type.
>=20
There is only difference in DMA channel and not in DMA node now. Does it
need add the precise compatible property name?

Thanks!
- zw
