Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51A30DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:31:32 +1100 (EST)
Subject: Re: Please pull from 'test'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0903171939360.26038@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0903171939360.26038@blarg.am.freescale.net>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 16:31:25 +1100
Message-Id: <1237527086.25062.564.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-17 at 19:40 -0500, Kumar Gala wrote:
> Please pull from 'test' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git test

Don't base your test branch on top of mine. Nothing should be based on
top of my test branch, it's volatile. Base your stuff on top of next.

We shouldn't have things staying long enough in 'test' that they deserve
being based upon.

Cheers,
Ben.

> to receive the following updates:
> 
>  arch/powerpc/include/asm/mmu.h      |    6 +
>  arch/powerpc/include/asm/mpic.h     |    5 +
>  arch/powerpc/kernel/cpu_setup_6xx.S |    4 +
>  arch/powerpc/kernel/cputable.c      |    9 +-
>  arch/powerpc/kernel/head_32.S       |  109 ++++++++++++++++++++++--------------
>  arch/powerpc/kernel/pci-common.c    |    2
>  arch/powerpc/sysdev/mpic.c          |   30 +++++++++
>  drivers/net/gianfar.c               |   34 +++++------
>  drivers/net/gianfar.h               |    3
>  9 files changed, 139 insertions(+), 63 deletions(-)
> 
> Kumar Gala (7):
>       powerpc: Add support for CoreInt delivery of interrupts on MPIC
>       powerpc/pci: Default to dma_direct_ops for pci dma_ops
>       powerpc/mm: Respect _PAGE_COHERENT on classic ppc32 SW TLB load machines
>       powerpc/mm: Remove unused register usage in SW TLB miss handling
>       powerpc/mm: Used free register to save a few cycles in SW TLB miss handling
>       powerpc/mm: e300c2/c3/c4 TLB errata workaround
>       gianfar: pass the proper dev to DMA ops
