Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFN2QWQzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:24 +1000 (AEST)
In-Reply-To: <1468709905.20552.165.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc/book64s: Move a few exception common handlers to make room
Message-Id: <3rsjFM6Gkwz9t0Z@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-16-07 at 22:58:25 UTC, Benjamin Herrenschmidt wrote:
> This moves the CBE RAS and facility unavailable "common" handlers
> down to after the FWNMI page.
> 
> This frees up some space in the very demanded spaces before the
> relocation-on vectors and before the FWNMI page. They are still
> within 64K of __start, so CONFIG_RELOCATABLE should still work.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b88d4bce2b883e7f357ecf8f0c

cheers
