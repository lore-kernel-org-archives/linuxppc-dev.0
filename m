Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vt7k43W5zF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 00:18:26 +1000 (AEST)
Date: Tue, 21 Aug 2018 15:59:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] sched/topology: Set correct numa topology type
Message-ID: <20180821135949.GI24082@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180821110258.GA2080@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180821110258.GA2080@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2018 at 04:02:58AM -0700, Srikar Dronamraju wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-08-10 22:30:18]:
> 
> > With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> > sched domain") scheduler introduces an new numa level. However this
> > leads to numa topology on 2 node systems no more marked as NUMA_DIRECT.
> > After this commit, it gets reported as NUMA_BACKPLANE. This is because
> > sched_domains_numa_level is now 2 on 2 node systems.
> > 
> > Fix this by allowing setting systems that have upto 2 numa levels as
> > NUMA_DIRECT.
> > 
> > While here remove a code that assumes level can be 0.
> > 
> > Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> 
> Hey Peter,
> 
> Did you look at these two patches?

Nope, been on holidays and the inbox is an even bigger mess than normal.
I'll get to it, eventually :/
