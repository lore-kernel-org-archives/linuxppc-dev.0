Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKW63KVzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:19 +1000 (AEST)
In-Reply-To: <1498325341.31581.90.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2] powerpc: Invalidate ERAT on powersave wakeup for POWER9
Message-Id: <3wyzKW34V1z9s76@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-06-24 at 17:29:01 UTC, Benjamin Herrenschmidt wrote:
> On POWER9 the ERAT may be incorrect on wakeup from some stop states
> that lose state. This causes random segvs and illegal instructions
> when these stop states are enabled.
> 
> This patch invalidates the ERAT on wakeup on POWER9 to prevent this
> from causing a problem.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ba6d334ac230065243a92bb7cb3fd6

cheers
