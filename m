Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKZ4w8rzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:22 +1000 (AEST)
In-Reply-To: <1498421326.31581.113.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: powerpc: Only do ERAT invalidate on radix context switch on P9 DD1
Message-Id: <3wyzKZ3919z9s8H@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-06-25 at 20:08:46 UTC, Benjamin Herrenschmidt wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> On P9 (Nimbus) DD2 and later, in radix mode, the move to the PID
> register will implicitly invalidate the user space ERAT entries
> and leave the kernel ones alone. Thus the only thing needed is
> an isync() to synchronize this with subsequent uaccess's 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74e27c6af56fe6898c3c8c45159574

cheers
