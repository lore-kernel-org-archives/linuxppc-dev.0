Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35E59DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 03:57:08 +1100 (EST)
Subject: Re: [PATCH 19/19] [POWERPC] pci_controller->arch_data really is a
	struct device_node *
From: Jon Loeliger <jdl@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071207020542.577bbfe8.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020542.577bbfe8.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1196960204.18340.7.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 06 Dec 2007 10:56:44 -0600
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-12-06 at 09:05, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/pci_32.c               |    6 +++---
>  arch/powerpc/kernel/pci_64.c               |    6 ++----
>  arch/powerpc/kernel/pci_dn.c               |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>  arch/powerpc/platforms/powermac/pci.c      |    2 +-
>  arch/powerpc/platforms/pseries/iommu.c     |    2 +-
>  include/asm-powerpc/pci-bridge.h           |    5 +++--
>  8 files changed, 13 insertions(+), 14 deletions(-)

I see that 86xx tinkering, so...

Acked-by:  Jon Loeliger <jdl@freescale.com>

that.

Thanks,
jdl
