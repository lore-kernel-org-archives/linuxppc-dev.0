Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9z66TyWzDqZT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:38 +1000 (AEST)
In-Reply-To: <1467695057-12431-15-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [14/41] powerpc/pmac: Remove early allocation of the SMU command
 buffer
Message-Id: <3rw9z65L2zz9sdg@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:50 UTC, Benjamin Herrenschmidt wrote:
> The SMU command buffer needs to be allocated below 2G using memblock.
> 
> In the past, this had to be done very early from the arch code as
> memblock wasn't available past that point. That is no longer the
> case though, smu_init() is called from setup_arch() when memblock
> is still functional these days. So move the allocation to the
> SMU driver itself.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/91b6fad5cf16c5fcf0ab2a08fc

cheers
