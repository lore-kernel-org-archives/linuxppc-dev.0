Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H5Cf0S1xzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 00:42:54 +1000 (AEST)
In-Reply-To: <20180405055755.30090-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/64s: Fix pkey support in dt_cpu_ftrs,
 add CPU_FTR_PKEY bit
Message-Id: <40H5Cd6Rkrz9s2B@ozlabs.org>
Date: Fri,  6 Apr 2018 00:42:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-05 at 05:57:54 UTC, Nicholas Piggin wrote:
> The pkey code added a CPU_FTR_PKEY bit, but did not add it to the
> dt_cpu_ftrs feature set. Although capability is supported by all
> processors in the base dt_cpu_ftrs set for 64s, it's a significant
> and sufficiently well defined feature to make it optional. So add
> it as a quirk for now, which can be versioned out then controlled
> by the firmware (once dt_cpu_ftrs gains versioning support).
> 
> Fixes: cf43d3b264 ("powerpc: Enable pkey subsystem ")
> Cc: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c130153e453cba0f37ad10fa18a1aa

cheers
