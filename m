Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPx55426szDvxW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 10:59:21 +1100 (AEDT)
In-Reply-To: <1479712085.10230.31.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: powerpc: Set missing wakeup bit in LPCR on POWER9
Message-Id: <3tPx546Fbjz9t2C@ozlabs.org>
Date: Fri, 25 Nov 2016 10:59:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-21 at 07:08:05 UTC, Benjamin Herrenschmidt wrote:
> There is a new bit, LPCR_PECEu0, which controls wakeup from STOP
> states on Hypervisor Virtualization Interrupts (which happen to
> also be all external interrupts in host or bare metal mode).
> 
> It needs to be set or we will miss wakeups.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7a43906f5cbfb74712af168988455e

cheers
