Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60l5WXBzDvsf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:15 +1100 (AEDT)
In-Reply-To: <20161108121445.15303-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc: fix graceful debugger recovery
Message-Id: <3tN60l4Bh5z9s5g@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 12:14:44 UTC, Nicholas Piggin wrote:
> When exiting xmon with 'x' (exit and recover), oops_begin bails
> out immediately, but die then calls __die() and oops_end(), which
> cause a lot of bad things to happen.
> 
> If the debugger was attached then went to graceful recovery, exit
> from die() immediately.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6f44b20ee9b4130345c189c0c90ef6

cheers
