Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPqmc2yNnzDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 23:59:12 +1000 (AEST)
Date: Wed, 8 Jun 2016 15:59:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
Message-ID: <20160608135903.GT30154@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
 <1465384845.13854.7.camel@ellerman.id.au>
 <20160608123507.GR30154@twins.programming.kicks-ass.net>
 <1465393760.10567.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465393760.10567.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2016 at 11:49:20PM +1000, Michael Ellerman wrote:

> > Ok; what tree does this go in? I have this dependent series which I'd
> > like to get sorted and merged somewhere.
> 
> Ah sorry, I didn't realise. I was going to put it in my next (which doesn't
> exist yet but hopefully will early next week).
> 
> I'll make a topic branch with just that commit based on rc2 or rc3?

Works for me; thanks!
