Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RgC55dnCzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 23:42:09 +1000 (AEST)
In-Reply-To: <20180411051801.30194-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc/xive: Fix trying to "push" an already active pool VP
Message-Id: <40RgC50rVzz9s37@ozlabs.org>
Date: Thu, 19 Apr 2018 23:42:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-11 at 05:17:59 UTC, Benjamin Herrenschmidt wrote:
> When setting up a CPU, we "push" (activate) a pool VP for it.
> 
> However it's an error to do so if it already has an active
> pool VP.
> 
> This happens when doing soft CPU hotplug on powernv since we
> don't tear down the CPU on unplug. The HW flags the error which
> gets captured by the diagnostics.
> 
> Fix this by making sure to "pull" out any already active pool
> first.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Patch 1 applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b32e56e5a87a1f9243db92bc7a5df0

cheers
