Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 49929DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 17:07:47 +1100 (EST)
Date: Thu, 12 Mar 2009 23:03:18 -0700
From: Greg KH <greg@kroah.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Remove extra semicolon in fsl_soc.c
Message-ID: <20090313060318.GA19770@kroah.com>
References: <ba5d9360903110850gbcb0d2y25f8756a19d46cda@mail.gmail.com>
	<fa686aa40903110903h1077860dt45c1a5aecd2ef42f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa40903110903h1077860dt45c1a5aecd2ef42f@mail.gmail.com>
Cc: afleming@freescale.com, Greg KH <gregkh@suse.de>,
	Johns Daniel <johns.daniel@gmail.com>, stable@kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 10:03:22AM -0600, Grant Likely wrote:
> On Wed, Mar 11, 2009 at 9:50 AM, Johns Daniel <johns.daniel@gmail.com> wrote:
> > A semicolon at the end of the macro means that the for loop has an
> > empty body, and so TSEC/MDIO will not work with older device trees.
> >
> > This fix only applies to 2.6.28; apparently, this code is gone for
> > 2.6.29, according to Grant Likely!
> >
> > Signed-off-by: Johns Daniel <johns.daniel@gmail.com>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Greg:  Andy Flemming should probably confirm this, but I think this
> one should be backported to the stable series.

Hm, this patch is line-wrapped and tabs are stripped, so I can't apply
it :(

Anyone care to resend it?

thanks,

greg k-h

> > ---
> > --- linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c.orig   2009-02-20
> > 16:41:27.000000000 -0600
> > +++ linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c        2009-03-10
> > 15:56:47.000000000 -0500
> > @@ -257,7 +257,7 @@
> >                gfar_mdio_of_init_one(np);
> >
> >        /* try the deprecated version */
> > -       for_each_compatible_node(np, "mdio", "gianfar");
> > +       for_each_compatible_node(np, "mdio", "gianfar")
> >                gfar_mdio_of_init_one(np);
> >
> >        return 0;
> > ---
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> 
> 
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
