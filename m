Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91DE4DDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 22:48:54 +1000 (EST)
Date: Tue, 8 Jul 2008 16:48:29 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: Re: powerpc: Add proper reference to dma_mask
Message-ID: <20080708164829.6817f344@vitb-lp>
In-Reply-To: <1215491291.8970.195.camel@pasglop>
References: <20080708031256.57176084@vitb-lp>
	<20080708135426.43edb5dc.sfr@canb.auug.org.au>
	<1215491291.8970.195.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=D0=92 Tue, 08 Jul 2008 14:28:11 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:

> On Tue, 2008-07-08 at 13:54 +1000, Stephen Rothwell wrote:
> > Hi Vitaly,
> >=20
> > On Tue, 8 Jul 2008 03:12:56 +0400 Vitaly Bordug
> > <vitb@kernel.crashing.org> wrote:
> > >
> > > +++ b/arch/powerpc/kernel/of_platform.c
> > > @@ -76,6 +76,9 @@ struct of_device*
> > > of_platform_device_create(struct device_node *np, return NULL;
> > > =20
> > >  	dev->dma_mask =3D 0xffffffffUL;
> > > +	dev->dev.dma_mask =3D &dev->dma_mask;
> >=20
> > That is done in of_device_alloc which is called just above.
>=20
> So the problem might just be that coherent_dma_mask isn't set.
>=20

I'll check and resubmit, thanks

-Vitaly
