Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCR1B9jzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:55 +1100 (AEDT)
In-Reply-To: <20170206025544.3292-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/powernv: Add XHCI and USB storage to defconfig
Message-Id: <3vJzCQ6vSBz9s7N@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-06 at 02:55:43 UTC, Michael Neuling wrote:
> These are common on bare metal machines, so put them in the defconfig.
> 
> This adds 216KB to the vmlinux size
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e623c54ec995899cf4179873070861

cheers
