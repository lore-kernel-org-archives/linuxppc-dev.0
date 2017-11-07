Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyz3TNyzDr6s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
In-Reply-To: <20171021075606.26814-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64: Fix latency tracing for lazy irq replay
Message-Id: <3yWlyy3VChz9sPk@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-10-21 at 07:56:06 UTC, Nicholas Piggin wrote:
> When returning from an exception to a soft-enabled context, pending
> IRQs are replayed but IRQ tracing is not reset, so a number of them
> can get chained together into the same IRQ-disabled trace.
> 
> Fix this by having __check_irq_replay re-set IRQ trace. This is
> conceptually where we respond to the next interrupt, so it fits the
> semantics of the IRQ tracer.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ff967900c9d4740f6337c6456f1111

cheers
