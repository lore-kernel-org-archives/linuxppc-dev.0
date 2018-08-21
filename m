Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnBK54g5zF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:35:21 +1000 (AEST)
In-Reply-To: <20180807132156.6183-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: idle_power4 fix PACA_IRQ_HARD_DIS accounting
Message-Id: <41vnBK4SdPz9s7X@ozlabs.org>
Date: Tue, 21 Aug 2018 20:35:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-07 at 13:21:56 UTC, Nicholas Piggin wrote:
> When idle_power4 hard disables interrupts then finds a soft pending
> interrupt, it returns with interrupts hard disabled but without
> PACA_IRQ_HARD_DIS set. Commit 9b81c0211c ("powerpc/64s: make
> PACA_IRQ_HARD_DIS track MSR[EE] closely") added a warning for that
> condition.
> 
> Fix this by adding the PACA_IRQ_HARD_DIS for that case.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/993ff6d9df74305bc7b5bbc7a0810c

cheers
