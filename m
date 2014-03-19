Return-Path: <davidlohr@hp.com>
Received: from g2t1383g.austin.hp.com (g2t1383g.austin.hp.com [15.217.136.92])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 544D02C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 05:06:25 +1100 (EST)
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by g2t1383g.austin.hp.com (Postfix) with ESMTPS id A63221DF0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 18:06:14 +0000 (UTC)
Message-ID: <1395252376.28137.26.camel@buesod1.americas.hpqcorp.net>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Davidlohr Bueso <davidlohr@hp.com>
To: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 19 Mar 2014 11:06:16 -0700
In-Reply-To: <20140319170829.GD8557@laptop.programming.kicks-ass.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 paulus@samba.org, tglx@linutronix.de,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-19 at 18:08 +0100, Peter Zijlstra wrote:
> On Wed, Mar 19, 2014 at 04:47:05PM +0100, Peter Zijlstra wrote:
> > > I reverted b0c29f79ecea0b6fbcefc999e70f2843ae8306db on top of v3.14-rc6 and confirmed that
> > > reverting the commit solved the problem.
> > 
> > Joy,.. let me look at that with ppc in mind.

errr... just sat down to check email this morning. CC'ing Paul as for
any subtle barrier issues.
