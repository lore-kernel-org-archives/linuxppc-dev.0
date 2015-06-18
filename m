Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 199101A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 16:12:08 +1000 (AEST)
Message-ID: <1434607927.20454.3.camel@neuling.org>
Subject: Re: [PATCH] cxl: Fix typo in debug print
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh <benh@kernel.crashing.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <ianmunsi@au1.ibm.com>
Date: Thu, 18 Jun 2015 16:12:07 +1000
In-Reply-To: <1434607064.25157.2.camel@ellerman.id.au>
References: <1434604510.2942.33.camel@neuling.org>
 <1434607064.25157.2.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-06-18 at 15:57 +1000, Michael Ellerman wrote:
> On Thu, 2015-06-18 at 15:15 +1000, Michael Neuling wrote:
> > Fix typo in debug print.  p1->p2.  No functional change.
>=20
> That's not "no functional change", it changes the behaviour, unless p2_ba=
se()
> implements the same logic as p1_base()?

Maybe I should change it to "Only debug output printing change"?

Mikey

>=20
> cheers
>=20
> > diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> > index 1ef0164..8515791 100644
> > --- a/drivers/misc/cxl/pci.c
> > +++ b/drivers/misc/cxl/pci.c
> > @@ -204,7 +204,7 @@ static void dump_cxl_config_space(struct pci_dev *d=
ev)
> >  	dev_info(&dev->dev, "p1 regs: %#llx, len: %#llx\n",
> >  		p1_base(dev), p1_size(dev));
> >  	dev_info(&dev->dev, "p2 regs: %#llx, len: %#llx\n",
> > -		p1_base(dev), p2_size(dev));
> > +		p2_base(dev), p2_size(dev));
> >  	dev_info(&dev->dev, "BAR 4/5: %#llx, len: %#llx\n",
> >  		pci_resource_start(dev, 4), pci_resource_len(dev, 4));
> > =20
> >=20
> >=20
>=20
>=20
>=20
>=20
