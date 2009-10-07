Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep18-int.chello.at (viefep18-int.chello.at [62.179.121.38])
	by ozlabs.org (Postfix) with ESMTP id E5325B7B84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 00:26:06 +1100 (EST)
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: balbir@linux.vnet.ibm.com
In-Reply-To: <20091007114719.GH6818@balbir.in.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	<20091006163521.GA10425@linux.vnet.ibm.com>
	<1254852279.17055.2.camel@laptop>
	<20091007112648.GC7646@dirshya.in.ibm.com>
	<20091007114719.GH6818@balbir.in.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 15:24:17 +0200
Message-Id: <1254921857.26976.249.camel@twins>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	arun@linux.vnet.ibm.com, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-07 at 17:17 +0530, Balbir Singh wrote:

> > The objective of the refactoring is to have a single common idle
> > routine management framework (remove pm_idle) and we have it done
> > through cpuidle registration framework.  We can incrementally remove
> > the per-cpu registration later easily by splitting the cpuidle_driver
> > structure.
> >
> 
> Yes, incremental refactoring makes the most sense from the do not
> break as you refactor point of view.

Sure,.. but I would have though getting rid of the per-cpu-ish-ness
would have made the latter patches in this series easier. But maybe I'm
lazy ;-)

Let me go over the patches one more time, but they do look ok.
