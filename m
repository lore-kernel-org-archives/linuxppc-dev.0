Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E9761A0D8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 20:24:52 +1100 (AEDT)
Date: Fri, 6 Nov 2015 10:24:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
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
Subject: Re: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
Message-ID: <20151106092430.GO3604@twins.programming.kicks-ass.net>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <563C5655.3000605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563C5655.3000605@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 12:57:17PM +0530, Madhavan Srinivasan wrote:
> 
> 
> On Thursday 05 November 2015 06:37 PM, Peter Zijlstra wrote:
> > On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
> >> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> >> and adds offsetof macro for the same. It extends perf_reg_value()
> >> to use reg idx to decide on struct to return value from.
> > Why; what's in those regs?
> 
> Was out and did not have access to mail, so missed to respond in time.
> 
> In current implementation of patch 2, have added 
> few pmu control/status and counter registers,
> which give additional information about the PMU context
> for the sample.

Yes, I saw that, you still haven't answered the question though. What is
in those regs? Why is exposing that information like this the best
option.
