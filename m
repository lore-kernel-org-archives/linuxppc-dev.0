Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqv61zq0zDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:38 +1000 (AEST)
In-Reply-To: <20170608153609.19217-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/4] powerpc/64s: context switch leave interrupts hard enabled
 for radix
Message-Id: <3wrqv60vpXz9sBR@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-08 at 15:36:06 UTC, Nicholas Piggin wrote:
> Commit 4387e9ff25 ("[POWERPC] Fix PMU + soft interrupt disable bug")
> hard disabled interrupts over the low level context switch, because
> the SLB management can't cope with a PMU interrupt accesing the stack
> in that window.
> 
> Radix based kernel mapping does not use the SLB so it does not require
> interrupts hard disabled here.
> 
> This is worth 1-2% in context switch performance on POWER9.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4c0fc5f72bca11432297168338aef

cheers
