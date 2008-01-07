Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49513DDEEE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:13:18 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 2/3] Add initial iomega StorCenter board port. 
In-Reply-To: Your message of "Mon, 07 Jan 2008 12:31:36 MST."
	<fa686aa40801071131u5d1adec8x84b269a14b492202@mail.gmail.com>
References: <E1JBwBn-0006JC-Nn@jdl.com>
	<fa686aa40801071131u5d1adec8x84b269a14b492202@mail.gmail.com>
Date: Mon, 07 Jan 2008 14:13:14 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JByLS-0007PJ-72@jdl.com>
Cc: linuxppc-dev@ozlabs.org, andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Grant Likely" mumbled:
> 
> Curious; why in platforms/embedded6xx vs platforms/82xx?

82xx is nominally the _other_ 82xx family. :-)
This is just more historical precedent, and the fact
that it is similar to the linkstation there.

> >  obj-$(CONFIG_MPC7448HPC2)      += mpc7448_hpc2.o
> >  obj-$(CONFIG_LINKSTATION)      += linkstation.o ls_uart.o
> > +obj-$(CONFIG_STORCENTER)       += storcenter.o
> >  obj-$(CONFIG_PPC_HOLLY)                += holly.o
> >  obj-$(CONFIG_PPC_PRPMC2800)    += prpmc2800.o
> > +obj-$(CONFIG_STORCENTER)       += storcenter.o
> 
> Linked twice?

I wanted to make double-sure to screw it up.  You know. :-)

Thanks,
jdl
