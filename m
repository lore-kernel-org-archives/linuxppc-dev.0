Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT16h6P7NzDrqg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 19:11:08 +1000 (AEST)
Date: Tue, 6 Sep 2016 11:10:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to
 perf_regs structure
Message-ID: <20160906091042.GJ10153@twins.programming.kicks-ass.net>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160901072629.GJ10153@twins.programming.kicks-ass.net>
 <750f1871-9efd-01d3-386d-be93908ca94a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <750f1871-9efd-01d3-386d-be93908ca94a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 09:55:43AM +0530, Madhavan Srinivasan wrote:
> 
> 
> On Thursday 01 September 2016 12:56 PM, Peter Zijlstra wrote:
> >On Mon, Aug 29, 2016 at 02:30:46AM +0530, Madhavan Srinivasan wrote:
> >>It's a perennial request from hardware folks to be able to
> >>see the raw values of the pmu registers. Partly it's so that
> >>they can verify perf is doing what they want, and some
> >>of it is that they're interested in some of the more obscure
> >>info that isn't plumbed out through other perf interfaces.
> >How much and what is that? Can't we try and get interfaces sorted?
> 
> We have bunch of registers which exports information regarding the
> sampled instruction like SIER/SIAR/SDAR/MMCRA. Lot of bits in these
> registers are not yet architected and incase of SIER register, some of
> the bits are not plumbed out and we are working on getting some these
> exposed via perf.

What kind of information is this? I'm not familiar with the Power PMU
all that much, so you'll have to spell it out, not just mention the
registers its stuffed in.
