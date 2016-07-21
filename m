Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9zH36mszDqYr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:47 +1000 (AEST)
In-Reply-To: <1467695057-12431-30-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [29/41] powerpc: Move 32-bit probe() machine to later in the boot
 process
Message-Id: <3rw9zH0BJQz9sf9@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:04:05 UTC, Benjamin Herrenschmidt wrote:
> This converts all the 32-bit platforms to use the expanded device-tree
> which is a pretty mechanical change. Unlike 64-bit, the 32-bit kernel
> didn't rely on platform initializations to setup the MMU since it
> sets it up entirely before probe_machine() so the move has comparatively
> less consequences though it's a bigger patch.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/565713840445b7ccafb28dc123

cheers
