Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqj1Y8czF0Wh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:09 +1100 (AEDT)
In-Reply-To: <20171116160052.18672-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/4] powerpc: define __ARCH_IRQ_EXIT_IRQS_DISABLED
Message-Id: <3zPxqh5qDDz9sP1@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-16 at 16:00:49 UTC, Nicholas Piggin wrote:
> powerpc calls irq_exit() with local irqs disabled, therefore it
> can define __ARCH_IRQ_EXIT_IRQS_DISABLED.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c16bee4bded5449ec3b3ec73579ba2

cheers
