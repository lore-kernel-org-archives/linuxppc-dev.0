Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98C2CDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:32:33 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: fix suspend states again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1174317726.22561.4.camel@johannes.berg>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105358.796834000@sipsolutions.net>
	<1174315727.5044.6.camel@localhost.localdomain>
	<1174317726.22561.4.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 16:32:22 +0100
Message-Id: <1174318342.5044.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 16:22 +0100, Johannes Berg wrote:
> On Mon, 2007-03-19 at 15:48 +0100, Benjamin Herrenschmidt wrote:
> 
> > > I removed
> > > 	set_context(current->active_mm->context.id, current->active_mm->pgd);
> 
> > No, you need that to restore the segment registers. I might work for you
> > by mere luck.
> 
> Hm, I thought they were saved by the lowlevel code, but yeah. I'll need
> to see where to put this. Btw, it looks like it's missing in
> powerbook_sleep_3400 as well?

No, on powerbook_sleep_3400, the CPU is never reset nor powered off.

Ben.
