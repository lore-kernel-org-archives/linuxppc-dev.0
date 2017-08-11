Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPFw3ffDzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:48 +1000 (AEST)
In-Reply-To: <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/pseries: energy driver only print message when LPAR guest
Message-Id: <3xTPFw2Tvlz9t32@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-21 at 01:16:44 UTC, Nicholas Piggin wrote:
> On Thu, 20 Jul 2017 23:03:21 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > 
> > > This driver currently reports the H_BEST_ENERGY is unsupported even
> > > when booting in a non-LPAR environment (e.g., powernv). Prevent it.  
> > 
> > Just delete the printk(). Users don't know what that means, and
> > developers have other better ways to detect that the hcall is missing if
> > anyone cares.
> > 
> > cheers
> 
> powerpc/pseries: energy driver do not print failure message
> 
> This driver currently reports the H_BEST_ENERGY is unsupported (even
> when booting in a non-LPAR environment). This is not something the
> administrator can do much with, and not significant for debugging.
> 
> Remove it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a70a0b9f4404d8edb72ca0e0272731

cheers
