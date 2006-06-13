Return-Path: <SRS0+4b0c712caa3c71df7734+1024+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 697CE67B21
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 22:38:48 +1000 (EST)
Subject: Re: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1150195883.5618.6.camel@vader.jdub.homelinux.org>
References: <1150170472.13958.13.camel@localhost.localdomain>
	<1150195883.5618.6.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:39:54 +0100
Message-Id: <1150202394.12423.16.camel@hades.cambridge.redhat.com>
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

On Tue, 2006-06-13 at 05:51 -0500, Josh Boyer wrote:
> It does?  I only see arch/powerpc in the patch.  Is arch/ppc hiding
> somewhere else?
> 
> And yes, arch/ppc still exists.  We can debate that later ;).

Did a maintainer step forward for it yet?

-- 
dwmw2
