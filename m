Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3F9B7DE12F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:10:27 +1100 (EST)
Date: Wed, 11 Mar 2009 09:05:47 -0700
From: Greg KH <greg@kroah.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [stable] [PATCH] powerpc: Remove extra semicolon in fsl_soc.c
Message-ID: <20090311160547.GA21668@kroah.com>
References: <ba5d9360903110850gbcb0d2y25f8756a19d46cda@mail.gmail.com>
	<fa686aa40903110903h1077860dt45c1a5aecd2ef42f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40903110903h1077860dt45c1a5aecd2ef42f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Greg KH <gregkh@suse.de>,
	Johns Daniel <johns.daniel@gmail.com>, afleming@freescale.com,
	stable@kernel.org
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

That's what he is asking for as he sent it to stable@kernel.org and
asked that it go into the 2.6.28 tree only :)

thanks,

greg k-h
