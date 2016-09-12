Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY25S0lQtzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 08:09:00 +1000 (AEST)
In-Reply-To: <1473648890-17909-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mroos@linux.ee
Subject: Re: powerpc/kernel: Fix size of NUM_CPU_FTR_KEYS on 32-bit
Message-Id: <3sY25R5SPmz9sfH@ozlabs.org>
Date: Tue, 13 Sep 2016 08:08:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-09 at 02:54:50 UTC, Michael Ellerman wrote:
> The number of CPU feature keys is meant to map 1:1 to the number of CPU
> feature flags defined in cputable.h, and the latter must fit in an
> unsigned long.
> 
> In commit 4db7327194db ("powerpc: Add option to use jump label for
> cpu_has_feature()"), I incorrectly defined NUM_CPU_FTR_KEYS to 64.
> 
> There should be no real adverse consequences of this bug, other than us
> allocating too many keys.
> 
> Fix it by using BITS_PER_LONG.
> 
> Fixes: 4db7327194db ("powerpc: Add option to use jump label for cpu_has_feature()")
> Tested-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/ffed15d3ce3f710b94e6f402e1

cheers
