Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] sched: fix capacity calculations for SMT4
In-reply-to: <1271688543.1488.253.camel@laptop>
References: <20100409062118.D4096CBB6C@localhost.localdomain>
	<1271161766.4807.1280.camel@twins> <2906.1271219317@neuling.org>
	<1271426308.1674.429.camel@laptop> <28214.1271626457@neuling.org>
	<1271688543.1488.253.camel@laptop>
Date: Tue, 20 Apr 2010 06:45:45 +1000
Message-ID: <715.1271709945@neuling.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <1271688543.1488.253.camel@laptop> you wrote:
> On Mon, 2010-04-19 at 07:34 +1000, Michael Neuling wrote:
> > > Are there any numbers available on how much they gain? It might be worth
> > > to stick in real numbers instead of this alleged 15%.
> > 
> > I get some gain numbers but obviously the workloads makes a huge
> > difference.  From a scheduler perspective, I assume an
> > average/representative gain is best rather than an optimistic or
> > pessimistic one?
> 
> Yeah, average would be best.

Ok.

> > We'll have different gains for SMT2 and SMT4, so we could change the
> > gain dynamically based on which SMT mode we are in.  Does that seem like
> > something we should add as an arch hook?  
> 
> That's the sort of thing you can use arch_scale_smt_power() for. But be
> weary to not fall into the same trap I did with x86, where I confused
> actual gain with capacity (When idle the actual gain is 0, but the
> capacity is not).

Oops, yes of course :-)

<from before>
> Hrmm, my brain seems muddled but I might have another solution, let me
> ponder this for a bit..

Let me know if/when you come up this solution or if I can help.  

Mikey
