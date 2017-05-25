Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVLJ6yjbzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:22:32 +1000 (AEST)
In-Reply-To: <20170524070326.13531-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, aneesh.kumar@linux.vnet.ibm.com, mikey@neuling.org,
 Greg Johnson <gwj@google.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N
Message-Id: <3wYVLJ5mgwz9s8P@ozlabs.org>
Date: Thu, 25 May 2017 23:22:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-24 at 07:03:26 UTC, Michael Neuling wrote:
> Currently if you disable CONFIG_PPC_RADIX_MMU you'll crash on boot on
> a P9. This is because we still set MMU_FTR_TYPE_RADIX via
> ibm,pa-features and MMU_FTR_TYPE_RADIX is what's used for code patching
> in much of the asm code (ie. slb_miss_realmode)
> 
> This patch fixes the problem by stopping MMU_FTR_TYPE_RADIX from being
> set from ibm.pa-features.
> 
> We may eventually end up removing the CONFIG_PPC_RADIX_MMU option
> completely but until then this fixes the issue.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d957fb4d173647640a2b83e7c7e56a

cheers
