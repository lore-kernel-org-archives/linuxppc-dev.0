Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-219-11.roch.qwest.net [71.36.219.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49E1167B30
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 10:43:32 +1000 (EST)
Subject: Re: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150240803.13958.66.camel@localhost.localdomain>
References: <1150170472.13958.13.camel@localhost.localdomain>
	<1150195883.5618.6.camel@vader.jdub.homelinux.org>
	<1150202394.12423.16.camel@hades.cambridge.redhat.com>
	<1150202794.29294.5.camel@weaponx.rchland.ibm.com>
	<1150240803.13958.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 19:43:14 -0500
Message-Id: <1150245794.4300.0.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-14 at 09:20 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-06-13 at 07:46 -0500, Josh Boyer wrote:
> > On Tue, 2006-06-13 at 13:39 +0100, David Woodhouse wrote:
> > > On Tue, 2006-06-13 at 05:51 -0500, Josh Boyer wrote:
> > > > It does?  I only see arch/powerpc in the patch.  Is arch/ppc hiding
> > > > somewhere else?
> > > > 
> > > > And yes, arch/ppc still exists.  We can debate that later ;).
> > > 
> > > Did a maintainer step forward for it yet?
> > 
> > For arch/ppc?  Not that I'm aware of.  But that wasn't particularly my
> > point.  The email says "This patch updates the ppc and powerpc
> > architectures..." when it doesn't.
> 
> It does, check again :)

Ugh.  Today is not my day apparently.  Sorry for the noise.

josh
