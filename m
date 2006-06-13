Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0CAB67B3C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 09:18:55 +1000 (EST)
Subject: Re: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1150195883.5618.6.camel@vader.jdub.homelinux.org>
References: <1150170472.13958.13.camel@localhost.localdomain>
	<1150195883.5618.6.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 09:18:23 +1000
Message-Id: <1150240703.13958.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-13 at 05:51 -0500, Josh Boyer wrote:
> On Tue, 2006-06-13 at 13:47 +1000, Benjamin Herrenschmidt wrote:
> > This patch updates the ppc and powerpc architectures to use the new
> > generic_handle_irq() so that interrupt controllers can be ported to the
> > new genirq layer.
> 
> It does?  I only see arch/powerpc in the patch.  Is arch/ppc hiding
> somewhere else?
> 
> And yes, arch/ppc still exists.  We can debate that later ;).

arch/ppc uses arch/powerpc/kernel/irq.c

Ben.
