Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4EA6679FF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 09:20:46 +1000 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add 85xx CDS to arch/powerpc 
In-Reply-To: Your message of "Mon, 03 Apr 2006 01:00:26 +0200."
	<200604030100.27013.arnd@arndb.de>
References: <Pine.LNX.4.61.0604021737010.9886@ld0175-tx32.am.freescale.net>
	<200604030100.27013.arnd@arndb.de>
Date: Sun, 02 Apr 2006 18:20:40 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FQBs8-00061K-BI@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Arnd Bergmann mumbled:
> [MPIC]
> 
> Shouldn't all this come from the device tree?
> 
> ...
>
> > +/* PCI interrupt controller */
> > +#define PIRQ0A			MPC85xx_IRQ_EXT0
> > +#define PIRQ0B			MPC85xx_IRQ_EXT1
> > +#define PIRQ0C			MPC85xx_IRQ_EXT2
> > +#define PIRQ0D			MPC85xx_IRQ_EXT3
> > +#define PIRQ1A			MPC85xx_IRQ_EXT11
> 
> And these as well, more importantly?

Yep.  In time they will.  However, the parsing of the
PIC nodes hasn't been added to the 85xx (uh, nor 83xx)
as of yet.

It is on "the list".

We should defer to Kumar to accepting these at this stage
or not.

jdl
