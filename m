Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Ky0WKHzDqyB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:34 +1000 (AEST)
In-Reply-To: <1467947595-21322-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Add MTD_BLOCK to powernv_defconfig
Message-Id: <3rp1Kx5lMMz9t0v@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-07 at 03:13:15 UTC, Michael Neuling wrote:
> This is so we can use the powernv_flash mtd driver as an block
> device.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/68a2d80c80e1563b8dc942d4ff

cheers
