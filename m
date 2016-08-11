Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s957c37YmzDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:16:44 +1000 (AEST)
In-Reply-To: <1470814054.3015.98.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christian Kujau <lists@nerdbynature.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Fix crash during static key init on ppc32
Message-Id: <3s957c2R3Dz9sR9@ozlabs.org>
Date: Thu, 11 Aug 2016 21:16:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-08 at 07:27:34 UTC, Benjamin Herrenschmidt wrote:
> We cannot do those initializations from apply_feature_fixups() as
> this function runs in a very restricted environment in 32-bit where
> the kernel isn't running at its linked address and the PTRRELOC()
> macro must be used for any global accesss.
> 
> Instead, split them into a separtate steup_feature_keys() function
> which is called in a more suitable spot on ppc32.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/97f6e0cc35026a2a09147a6da6

cheers
