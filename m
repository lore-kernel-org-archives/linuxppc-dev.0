Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19127.24899.576444.303678@cargo.ozlabs.ibm.com>
Date: Mon, 21 Sep 2009 21:19:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
In-Reply-To: <20090921071127.GA24467@elte.hu>
References: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
	<20090921071127.GA24467@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Markus Metzger <markus.t.metzger@intel.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ingo Molnar writes:

> Paul, you might also want to test the perfcounter bits of -tip on 
> PowerPC a bit more frequently - this patch was there for 5 days before i 
> sent it to Linus.

Yes, I'll try to do that in future.

I hope I didn't come across as blaming anyone for anything - that
wasn't my intention at all.

> Cross-builds didnt catch it as perfcounters isnt enabled by default in 
> any of the powerpc defconfigs:

I'll get that fixed too.

Paul.
