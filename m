Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xC3f3SzF2M4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:18 +1100 (AEDT)
In-Reply-To: <20180109054520.31704-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel] powerpc/init: Do not advertise radix during
 client-architecture-support
Message-Id: <40B8x95dzHz9s0q@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-09 at 05:45:20 UTC, Alexey Kardashevskiy wrote:
> Currently the pseries kernel advertises radix MMU support even if
> the actual support is disabled via the CONFIG_PPC_RADIX_MMU option.
> 
> This adds a check for CONFIG_PPC_RADIX_MMU to avoid advertising radix
> to the hypervisor.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/79b4686857029cdea97d0102d179ae

cheers
