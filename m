Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A66EEDDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 06:14:49 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] powerpc: irqtrace support to 64-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1193060107.9793.8.camel@johannes.berg>
References: <20071015072826.2D541DDE16@ozlabs.org>
	<1193060107.9793.8.camel@johannes.berg>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 06:14:42 +1000
Message-Id: <1193084082.6745.91.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-22 at 15:35 +0200, Johannes Berg wrote:
> On Mon, 2007-10-15 at 17:28 +1000, Benjamin Herrenschmidt wrote:
> > This adds the low level irq tracing hooks to the powerpc architecture
> > needed to enable full lockdep functionality
> > 
> > Some rework from Johannes initial version, removing the asm trampoline that
> > isn't needed (thus improving perfs) and fixing a couple of bugs such as
> > incorrect initial preempt_count on the softirq alternate stack.
> 
> Hmm. It breaks booting on my quad, I finally got around to testing
> without this patch and it turns out that it caused the boot failure I
> reported in another mail. This is with v2.6.23-6623-g55b70a0, a clean
> tree boots fine but with these two patches applied and configured in it
> fails during boot, hanging at some point, apparently when userspace is
> entered.
> 
> On the other hand, it is fine with my original version. I'll have to
> find some time to check the differences hunk by hunk I guess.

Or I can try on my quad :-) I'll have a look. It did boot on some other
machines though. Funny.

Ben.
