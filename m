Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W9l0HYFzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:46:35 +1000 (AEST)
In-Reply-To: <1467957343.2874.21.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/pnv/pci: Fix incorrect PE reservation attempt on
 some 64-bit BARs
Message-Id: <3s8W9k6ZtJz9t23@ozlabs.org>
Date: Wed, 10 Aug 2016 22:46:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-07 at 05:55:43 UTC, Benjamin Herrenschmidt wrote:
> The generic allocation code may sometimes decide to assign a prefetchable
> 64-bit BAR to the M32 window. In fact it may also decide to allocate
> a 64-bit non-prefetchable BAR to the M64 one ! So using the resource
> flags as a test to decide which window was used for PE allocation is
> just wrong and leads to insane PE numbers.
> 
> Instead, compare the addresses to figure it out.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5958d19a143eb229e9ece20bd4

cheers
