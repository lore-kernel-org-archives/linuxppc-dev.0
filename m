Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1FB91A027D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 19:06:23 +1100 (AEDT)
Date: Wed, 14 Oct 2015 10:06:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/6] powerpc: atomic: Make *xchg and *cmpxchg a
 full barrier
Message-ID: <20151014080613.GP17308@twins.programming.kicks-ass.net>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
 <1444781400.12197.4.camel@ellerman.id.au>
 <20151014005134.GE23991@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014005134.GE23991@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 08:51:34AM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 11:10:00AM +1100, Michael Ellerman wrote:

> > Thanks for fixing this. In future you should send a patch like this as a
> > separate patch. I've not been paying attention to it because I assumed it was
> 
> Got it. However, here is the thing, in previous version, this fix
> depends on some of other patches in this patchset. So to make this fix
> applied cleanly, I reorder my patchset to put this patch first, and the
> result is that some of other patches in this patchset depends on
> this(they need to remove code modified by this patch).
> 
> So I guess I'd better to stop Cc stable for this one, and wait until
> this patchset merged and send a separate patch for -stable tree. Does
> that work for you? I think this is what Peter want to suggests me to do
> when he asked me about this, right, Peter?

I don't think I had explicit thoughts about any of that, just that it
might make sense to have this patch not depend on the rest such that it
could indeed be stuffed into stable.

I'll leave the details up to Michael since he's PPC maintainer.
