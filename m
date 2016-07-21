Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9zR6V2qzDqYr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:55 +1000 (AEST)
In-Reply-To: <1469074895-26281-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3] powerpc: Merge 32-bit and 64-bit setup_arch()
Message-Id: <3rw9zR3zmLz9sxR@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-21-07 at 04:21:35 UTC, Michael Ellerman wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> There is little enough differences now.
> 
> mpe: Add a/p/k/setup.h to contain the prototypes and empty versions of
> functions we need, rather than using weak functions. Add a few other
> empty versions to avoid as many #ifdefs as possible in the code.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/b1923caa6e641f3d0a93b5d045

cheers
