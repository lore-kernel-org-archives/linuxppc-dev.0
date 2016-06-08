Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPmFp2YvbzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:20:46 +1000 (AEST)
Message-ID: <1465384845.13854.7.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Date: Wed, 08 Jun 2016 21:20:45 +1000
In-Reply-To: <20160606144659.GG30909@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 16:46 +0200, Peter Zijlstra wrote:
> On Mon, Jun 06, 2016 at 10:17:25PM +1000, Michael Ellerman wrote:
> > On Mon, 2016-06-06 at 13:56 +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 06, 2016 at 09:42:20PM +1000, Michael Ellerman wrote:
> > > 
> > > Why the move to in-line this implementation? It looks like a fairly big
> > > function.
> > 
> > I agree it's not pretty.
> 
> > I'm not beholden to v3 though if you hate it.
> 
> I don't mind; its just that I am in a similar boat with qspinlock and
> chose the other option. So I just figured I'd ask :-)

OK. I'll go with inline and we'll see which version gets "cleaned-up" by a
janitor first ;)

cheers
