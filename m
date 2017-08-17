Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY5x767bxzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:03:07 +1000 (AEST)
In-Reply-To: <20170816060118.24803-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/5] powerpc: Test MSR_FP and MSR_VEC when enabling/flushing VSX
Message-Id: <3xY5x75Jyhz9t4R@ozlabs.org>
Date: Thu, 17 Aug 2017 23:03:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-16 at 06:01:14 UTC, Benjamin Herrenschmidt wrote:
> VSX uses a combination of the old vector registers, the old FP registers
> and new "second halves" of the FP registers.
> 
> Thus when we need to see the VSX state in the thread struct
> (flush_vsx_to_thread) or when we'll use the VSX in the kernel
> (enable_kernel_vsx) we need to ensure they are all flushed into
> the thread struct if either of them is individually enabled.
> 
> Unfortunately we only tested if the whole VSX was enabled, not
> if they were individually enabled.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5a69aec945d27e78abac9fd032533d

cheers
