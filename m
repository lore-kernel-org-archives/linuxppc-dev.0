Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvCTK6VXmzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 19:15:01 +1000 (AEST)
In-Reply-To: <20170620074447.15532-1-santosh@fossix.org>
To: Santosh Sivaraj <santosh@fossix.org>, naveen.n.rao@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc/time: Fix tracing in time.c
Message-Id: <3wvCTK5qcKz9sNV@ozlabs.org>
Date: Fri, 23 Jun 2017 19:15:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-20 at 07:44:47 UTC, Santosh Sivaraj wrote:
> Since trace_clock is in a different file and already marked with notrace,
> enable tracing in time.c by removing it from the disabled list in Makefile.
> Also annotate clocksource read functions and sched_clock with notrace.
> 
> Testing: Timer and ftrace selftests run with different trace clocks.
> 
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Applied to powerpc next-test, thanks.

https://git.kernel.org/powerpc/c/6b847d795cf4ab3e574f4fcf7193fe

cheers
