Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702t3FzrzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:42 +1100 (AEDT)
In-Reply-To: <20170929032942.4321-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 1/6] powerpc/watchdog: do not panic from locked CPU's IPI handler
Message-Id: <3y702t0Vsfz9t5R@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 03:29:37 UTC, Nicholas Piggin wrote:
> The SMP watchdog will detect locked CPUs and IPI them to print a
> backtrace and registers. If panic on hard lockup is enabled, do
> not panic from this handler, because that can cause recursion into
> the IPI layer during the panic.
> 
> The caller already panics in this case.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/842dc1dbabb5e874550b52d896851e

cheers
