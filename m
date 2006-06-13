Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-219-11.roch.qwest.net [71.36.219.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B39667B37
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 22:47:08 +1000 (EST)
Subject: Re: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1150202394.12423.16.camel@hades.cambridge.redhat.com>
References: <1150170472.13958.13.camel@localhost.localdomain>
	<1150195883.5618.6.camel@vader.jdub.homelinux.org>
	<1150202394.12423.16.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 07:46:34 -0500
Message-Id: <1150202794.29294.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-13 at 13:39 +0100, David Woodhouse wrote:
> On Tue, 2006-06-13 at 05:51 -0500, Josh Boyer wrote:
> > It does?  I only see arch/powerpc in the patch.  Is arch/ppc hiding
> > somewhere else?
> > 
> > And yes, arch/ppc still exists.  We can debate that later ;).
> 
> Did a maintainer step forward for it yet?

For arch/ppc?  Not that I'm aware of.  But that wasn't particularly my
point.  The email says "This patch updates the ppc and powerpc
architectures..." when it doesn't.

I think most agree that arch/ppc needs to die via a complete migration
to arch/powerpc.  But patches shouldn't claim to do something they
don't :).

josh
