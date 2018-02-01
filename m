Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXLHv22h4zDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 00:17:15 +1100 (AEDT)
In-Reply-To: <20180131141310.4938-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/mm/radix: Fix build error when RADIX_MMU=n
Message-Id: <3zXLHt6ZYWz9sR8@ozlabs.org>
Date: Fri,  2 Feb 2018 00:17:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-31 at 14:13:10 UTC, Michael Ellerman wrote:
> The recent TLB flush rework broke the build when the Radix MMU is
> disabled at build time, eg:
> 
>   (.text+0x264): undefined reference to `.radix__tlbiel_all'
> 
> We could add an empty version, but if we ever called it by accident
> that would indicate a bad bug, so add a stub that just WARNs if we do.
> 
> Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/015eb1b89e959c9349f0a01803fb8e

cheers
