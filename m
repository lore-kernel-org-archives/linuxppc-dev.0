Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A99D82C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 18:24:23 +1100 (EST)
Date: Thu, 20 Mar 2014 08:23:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140320072359.GF27965@twins.programming.kicks-ass.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140320053350.GB30295@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 davidlohr@hp.com, paulus@samba.org, tglx@linutronix.de,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, torvalds@linux-foundation.org,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 11:03:50AM +0530, Srikar Dronamraju wrote:
> > > Joy,.. let me look at that with ppc in mind.
> > 
> > OK; so while pretty much all the comments from that patch are utter
> > nonsense (what was I thinking), I cannot actually find a real bug.
> > 
> > But could you try the below which replaces a control dependency with a
> > full barrier. The control flow is plenty convoluted that I think the
> > control barrier isn't actually valid anymore and that might indeed
> > explain the fail.
> > 
> 
> Unfortunately the patch didnt help. Still seeing tasks stuck

Aww bugger. I'll be traveling tomorrow and today is wasted getting
ready. So unless Davidlohr has anything we'll need to scrap this change.
