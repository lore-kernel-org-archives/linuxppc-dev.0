Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzyBj1B71zDrpq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:32:45 +1000 (AEST)
In-Reply-To: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [v2,1/2] powerpc/mm: Fix build break when PPC_NATIVE=n
Message-Id: <3rzyBh61kbz9t25@ozlabs.org>
Date: Thu, 28 Jul 2016 00:32:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-07 at 03:38:37 UTC, Michael Ellerman wrote:
> The recent commit to rework the hash MMU setup broke the build when
> CONFIG_PPC_NATIVE=n. Fix it by adding an IS_ENABLED() check before
> calling hpte_init_native().
> 
> Removing the else clause opens the possibility that we don't set any
> ops, which would probably lead to a strange crash later. So add a check
> that we correctly initialised at least one member of the struct.
> 
> Fixes: 166dd7d3fbf2 ("powerpc/64: Move MMU backend selection out of platform code")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/7353644fa9df875aee778a802e

cheers
