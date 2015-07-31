Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 885241A17B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:13:32 +1000 (AEST)
In-Reply-To: <1438239234-29480-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: powerpc/eeh-powernv: Fix unbalanced IRQ warning
Message-Id: <20150731041332.6C02F140322@ozlabs.org>
Date: Fri, 31 Jul 2015 14:13:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-30-07 at 06:53:54 UTC, Alistair Popple wrote:
> pnv_eeh_next_error() re-enables the eeh opal event interrupt but it
> gets called from a loop if there are more outstanding events to
> process, resulting in a warning due to enabling an already enabled
> interrupt. Instead the interrupt should only be re-enabled once the
> last outstanding event has been processed.
> 
> Tested-by: Daniel Axtens <dja@axtens.net>
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b8d65e9662b1ffb3b52a

cheers
