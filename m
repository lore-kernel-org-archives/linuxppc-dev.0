Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mvVD12jxzF27l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:55:00 +1000 (AEST)
In-Reply-To: <20180514155947.22753-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/2] powerpc/powernv: Fix NVRAM sleep in invalid context when
 crashing
Message-Id: <40mvVD0P0wz9s4Y@ozlabs.org>
Date: Fri, 18 May 2018 00:55:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 15:59:47 UTC, Nicholas Piggin wrote:
> Similarly to opal_event_shutdown, opal_nvram_write can be called in
> the crash path with irqs disabled. Special case the delay to avoid
> sleeping in invalid context.
> 
> Cc: stable@vger.kernel.org # v3.2
> Fixes: 3b8070335f ("powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c1d2a31397ec51f0370f6bd17b19b3

cheers
