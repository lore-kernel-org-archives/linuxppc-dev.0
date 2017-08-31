Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLb2QzdzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:23 +1000 (AEST)
In-Reply-To: <20170828042719.18197-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64: Fix watchdog configuration regressions
Message-Id: <3xjgLZ5vhsz9t2R@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 04:27:19 UTC, Nicholas Piggin wrote:
> This fixes a couple more bits of fallout from the new hard lockup watchdog
> patch.
> 
> It restores the required hw_nmi_get_sample_period() function for the
> perf watchdog, and removes some function declarations on 64e that are only
> defined for 64s. This fixes the 64e build when the hardlockup detector is
> enabled.
> 
> It restores the default behaviour of disabling the perf watchdog, and also
> fixes disabling the 64s watchdog when running as a guest.
> 
> Fixes: 2104180a53 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/70412c55d419e971785094e9f7880f

cheers
