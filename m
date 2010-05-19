Return-Path: <horms@verge.net.au>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 42871B7D6F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 10:45:31 +1000 (EST)
Date: Wed, 19 May 2010 09:22:27 +0900
From: Simon Horman <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] kexec-tools, ppc64: Fix segfault parsing DR memory
	property
Message-ID: <20100519002227.GC8536@verge.net.au>
References: <4BECBE89.3020108@ozlabs.org>
 <23148.1274139032@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23148.1274139032@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 18, 2010 at 09:30:32AM +1000, Michael Neuling wrote:
> 
> 
> In message <4BECBE89.3020108@ozlabs.org> you wrote:
> > add_dyn_reconf_usable_mem_property() iterates over memory spans
> > in /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory and intersects
> > these with usablemem_rgns ranges.  In doing so it used an unchecked
> > fixed-size array which will overrun on machines with lots of LMBs.
> > 
> > This patch removes the fixed-sized arrays from
> > add_dyn_reconf_usable_mem_property() and add_usable_mem_property(), in lieu o
> f
> > malloc/realloc/free.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> So this works our large P7 machine unlike the last one.
> 
> Acked-by: Michael Neuling <mikey@neuling.org>

Thanks, applied
