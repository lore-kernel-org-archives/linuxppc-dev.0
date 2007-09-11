Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E491DDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 20:06:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8BA6CiF012333
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:06:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l8BA6BKj019336
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:06:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Date: Tue, 11 Sep 2007 18:06:10 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D61C@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070907085845.54dc88f8.randy.dunlap@oracle.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<20070907085845.54dc88f8.randy.dunlap@oracle.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,=20
> --- /dev/null
> > +++ b/drivers/dma/fsldma.c
> > @@ -0,0 +1,995 @@
>=20
> Thanks for using kernel-doc notation.  However, ...
>=20
> > +/**
> > + * fsl_dma_alloc_descriptor - Allocate descriptor from=20
> channel's DMA pool.
>=20
> Function parameters need to be listed & described here.
> See Documentation/kernel-doc-nano-HOWTO.txt or other source files
> for examples.
>=20
> (Applies to all documented function interfaces here.)

All right, I'll add full descriptions here. :P

>=20
> > + *
> > + * Return - The descriptor allocated. NULL for failed.
> > + */
> > +static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
> > +					struct fsl_dma_chan *fsl_chan,
> > +					gfp_t flags)
> > +{
> ...
> > +}
>=20
> > +/**
> > + * fsl_chan_xfer_ld_queue -- Transfer the link descriptors=20
> in channel
> > + *                           ld_queue.
>=20
> The function's "short description" (unfortunately) must be on only one
> line.  E.g.:
>=20
>  * fsl_chan_xfer_ld_queue - Transfer link descriptors in=20
> channel ld_queue.
>=20

How about it's length greater than 80?

> > + */
> > +static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
> > +{
> ...
> > +}
>=20
> > diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> > new file mode 100644
> > index 0000000..05be9ed
> > --- /dev/null
> > +++ b/drivers/dma/fsldma.h
> > @@ -0,0 +1,188 @@
> > +struct fsl_dma_chan_regs {
> > +	__mix32	mr;		/* 0x00 - Mode Register */
> > +	__mix32	sr;		/* 0x04 - Status Register */
> > +	__mix64	cdar;		/* 0x08 - Cureent descriptor=20
> address register */
>=20
>                                           Current
>=20

I'll fix it.

Thanks!
- zw
