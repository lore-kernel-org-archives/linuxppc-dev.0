Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B409DDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 20:13:18 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l8CAD88t028229
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:13:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8CAD6h4014662
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:13:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 12 Sep 2007 18:13:09 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070911141907.GF1932@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
	<20070911141907.GF1932@ld0162-tx32.am.freescale.net>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
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

> > >=20
> > > On Fri, Sep 07, 2007 at 04:43:35PM +0200, Segher=20
> Boessenkool wrote:
> > > > > +   l) Freescale DMA
> > > >=20
> > > > > +    - compatible : Should be "fsl,dma".
> > > >=20
> > > > Please choose some more specific name.  "fsl,mpc8540-dma" would
> > > > be a reasonable choice perhaps.
> > >=20
> > > More precisely, the compatible property should always=20
> have an specific
> > > entry based on the exact chip the DMA engine resides in,=20
> as well as a
> > > more general entry for any fsl dma engine of this type.
> > >=20
> > There is only difference in DMA channel and not in DMA node=20
> now. Does it
> > need add the precise compatible property name?
>=20
> Yes.  First of all, there most likely is a difference -- the=20
> endianness
> of the shared status summary register.  Secondly, the device=20
> tree should
> not make assumptions as far as whether the user is going to bind to
> individual channels or the whole controller.

I have a strange issue here. If I rename 'fsl,dma' to 'fsl,mpc8540-dma',
the 'fsl,mpc8540-dma-channel' will be also regarded as DMA device not
DMA channel.

Thanks!
- zw
