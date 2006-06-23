Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2093B67A65
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 00:06:14 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Use IRQ and senses from OF-tree on 8641hpcn. 
In-Reply-To: Your message of "Fri, 23 Jun 2006 10:11:37 +1000."
	<1151021497.4046.79.camel@localhost.localdomain>
References: <1150999473.9022.79.camel@cashmere.sps.mot.com>
	<1151021497.4046.79.camel@localhost.localdomain>
Date: Fri, 23 Jun 2006 09:06:09 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FtmIT-0007p2-KW@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> 
> > +	shift = __ilog2((~interrupt_mask[0] + 1) & 0xffff);
> 
> Nice hack :)

We aim to please. :-)

> But not something mergeable as it strictly relies on the specific format
> of the interrupt map on that platform :)

Hrm.

> I have a generic parser on the way, it's hot and will be released for
> public consumption later today or this week-end along with the rest of
> the irq patches.

Chomp, chomp.

> I'll need you guys to help porting the few embedded boards already in
> arch/powerpc.

Of course.  We've also lined Andy Fleming up to help
with some 85xx parts, and Kim Phillips to help with
some 83xx parts.  (Hi guys!)

BTW and for (your) references, I will follow up with
the complete MPC8641 HPCN DTS file here!

Thanks,
jdl
