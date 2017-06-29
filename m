Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKG5h7QzDr4k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:06 +1000 (AEST)
In-Reply-To: <20170508062331.11074-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Subject: Re: powerpc: Fix asm offsets to point to actual FP and VMX regs
Message-Id: <3wyzKG2Twgz9s3s@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-08 at 06:23:31 UTC, Michael Neuling wrote:
> The asm code assumes the FP regs are at the start of fp_state. While
> this is true now, it may not always be the case and there is nothing
> enforcing it.
> 
> This fixes the asm-offsets to point to the actual FP registers inside
> the fp_state.  Similarly for VMX.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aa9a95163638bd9acb3e1f61f48cd5

cheers
