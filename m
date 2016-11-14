Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzN0540zDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:04 +1100 (AEDT)
In-Reply-To: <20161031021939.30989-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Jack Miller <jack@codezen.org>
Subject: Re: [1/2] Revert "selftests/powerpc: Load Monitor Register Tests"
Message-Id: <3tHTzM6MrWz9s5w@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-31-10 at 02:19:38 UTC, Michael Neuling wrote:
> Load monitored won't be supported in POWER9, so PPC_FEATURE2_ARCH_3_00
> (in HWCAP2) will no longer imply Load monitor support.
> 
> These Load monitored tests are enabled by PPC_FEATURE2_ARCH_3_00 so
> they are now bogus and need to be removed.
> 
> This reverts commit 16c19a2e983346c547501795aadffde1977b058d.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c65856b7e0d12f2be2adae7a75a11

cheers
