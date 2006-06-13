Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-219-11.roch.qwest.net [71.36.219.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FB9967A63
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 21:10:23 +1000 (EST)
Subject: Re: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150170472.13958.13.camel@localhost.localdomain>
References: <1150170472.13958.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 05:51:23 -0500
Message-Id: <1150195883.5618.6.camel@vader.jdub.homelinux.org>
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

On Tue, 2006-06-13 at 13:47 +1000, Benjamin Herrenschmidt wrote:
> This patch updates the ppc and powerpc architectures to use the new
> generic_handle_irq() so that interrupt controllers can be ported to the
> new genirq layer.

It does?  I only see arch/powerpc in the patch.  Is arch/ppc hiding
somewhere else?

And yes, arch/ppc still exists.  We can debate that later ;).

josh
