Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60E361A0166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:33:19 +1100 (AEDT)
Date: Wed, 14 Oct 2015 11:33:07 +0200
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
Message-ID: <20151014093307.GC3816@twins.programming.kicks-ass.net>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
 <1444781400.12197.4.camel@ellerman.id.au>
 <20151014005134.GE23991@fixme-laptop.cn.ibm.com>
 <20151014080613.GP17308@twins.programming.kicks-ass.net>
 <20151014092653.GA29432@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014092653.GA29432@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 05:26:53PM +0800, Boqun Feng wrote:
> Michael and Peter, rest of this patchset depends on commits which are
> currently in the locking/core branch of the tip, so I would like it as a
> whole queued there. Besides, I will keep this patch Cc'ed to stable in
> future versions, that works for you both?

>From my POV having the Cc stable in there is fine if Michael actually
wants them to go there. GregKH will vacuum them up once they hit Linus'
tree and we don't need to think about it anymore.

Alternatively, Michael could put the patch in a separate branch and we
could both merge that.

Or even, seeing how its a single patch and git mostly does the right
thing, we could just merge it independently in both trees and let git
sort it out at merge time.
