Return-Path: <akpm@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 95F08DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 10:18:24 +1100 (EST)
Date: Mon, 5 Feb 2007 15:18:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
Message-Id: <20070205151816.d841633b.akpm@linux-foundation.org>
In-Reply-To: <1170716376.2620.141.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.099816000@sipsolutions.net>
	<1170716376.2620.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 06 Feb 2007 09:59:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> > plain text document attachment (irq-comment.patch)
> > kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> > numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.
> > 
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Andrew Morton <akpm@osdl.org>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I hope that wasn't acked at me.  I was only copied on half this patch
series and I only picked up swsusp-dont-copy-pages-that-arent-ram.patch and
windfarm-dont-die-on-suspend-thread-signal.patch.
