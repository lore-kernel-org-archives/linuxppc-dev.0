Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B43BD1A0452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:00:08 +1000 (AEST)
Message-ID: <1434002408.28304.4.camel@ellerman.id.au>
Subject: Re: question on FSL_EMB perf
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Thu, 11 Jun 2015 16:00:08 +1000
In-Reply-To: <20150610114126.GN19282@twins.programming.kicks-ass.net>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
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

On Wed, 2015-06-10 at 13:41 +0200, Peter Zijlstra wrote:
> Hi Mike, Ben,
> 
> I just noticed:
> 
> arch/powerpc/Kconfig:   select HAVE_PERF_EVENTS_NMI if PPC64

We actually only added that recently, in c54b2bf1b5e9 "powerpc: Add ppc64 hard
lockup detector support".

AFAICS it doesn't actually have anything to do with the NMI behaviour of the
perf interrupt. It controls whether the hardlockup detector is enabled and/or
the oprofile NMI timer.

cheers
