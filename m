Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C2D9DDE09
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 10:54:05 +1100 (EST)
Subject: Re: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070205151816.d841633b.akpm@linux-foundation.org>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.099816000@sipsolutions.net>
	<1170716376.2620.141.camel@localhost.localdomain>
	<20070205151816.d841633b.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 10:53:47 +1100
Message-Id: <1170719627.2620.157.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-05 at 15:18 -0800, Andrew Morton wrote:
> On Tue, 06 Feb 2007 09:59:36 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> > > plain text document attachment (irq-comment.patch)
> > > kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> > > numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.
> > > 
> > > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > > Cc: Andrew Morton <akpm@osdl.org>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> I hope that wasn't acked at me.  I was only copied on half this patch
> series and I only picked up swsusp-dont-copy-pages-that-arent-ram.patch and
> windfarm-dont-die-on-suspend-thread-signal.patch.

This one is really independant of the rest, so it can be picked up by
either you or paulus or both, whoever jumps on it first :-) I wrote the
code this comment refers to so I just reviewed & acked :-)

Ben.
