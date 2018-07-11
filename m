Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft61GpdzF35P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:14 +1000 (AEST)
In-Reply-To: <1529360102-8206-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: powerpc/pci: Remove legacy debug code
Message-Id: <41Qft44gbbzB4MZ@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 22:15:02 UTC, Breno Leitao wrote:
> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> removed the 'oirq' variable, but kept memsetting it when the DEBUG macro is
> defined.
> 
> When setting DEBUG macro for debugging purpose, the kernel fails to build since
> 'oirq' is not defined anymore.
> 
> This patch simply remove the debug block, since it does not seem to sense
> now.
> 
> Fixes: 59f47eff03a08c ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3bfb450ee7b52d41ce2117738ee9c1

cheers
