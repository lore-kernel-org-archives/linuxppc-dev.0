Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBM06b3qzDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:16 +1000 (AEST)
In-Reply-To: <20170625023905.24649-1-oss@buserror.net>
To: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>, Jurgen Schindele <schindele@nentec.de>
Subject: Re: powerpc/ipic: Support edge on IRQ0
Message-Id: <3xJBM04WhRz9s8V@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-06-25 at 02:39:05 UTC, Scott Wood wrote:
> External IRQ0 has the same capabilities as the other IRQ1-7 and is
> handled by the same register IPIC_SEPNR.  When this register is not
> specified for "ack" in "ipic_info", you cannot configure this IRQ as
> IRQ_TYPE_EDGE_FALLING.  This oversight was probably due to the
> non-contiguous hwirq numbering of IRQ0 in the IPIC.
> 
> Signed-off-by: Jurgen Schindele <schindele@nentec.de>
> [scottwood: Cleaned up commit message and posted as a proper patch]
> Signed-off-by: Scott Wood <oss@buserror.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/446183e4069e0b62cedfd72ccb90b8

cheers
