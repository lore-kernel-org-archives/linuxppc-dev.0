Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvD4cVnzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:24 +1000 (AEST)
In-Reply-To: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nick Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/64: Correct comment on LOAD_HANDLER()
Message-Id: <3sYNvD3lCBz9snm@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-07 at 05:29:29 UTC, Michael Ellerman wrote:
> The comment for LOAD_HANDLER() was wrong. The part about kdump has not
> been true since 1f6a93e4c35e ("powerpc: Make it possible to move the
> interrupt handlers away from the kernel").
> 
> Describe how it currently works, and combine the two separate comments
> into one.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nick Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/27510235dd2bb1ab01d27b01f0

cheers
