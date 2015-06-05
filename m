Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id A0CE51A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 12:11:34 +1000 (AEST)
Date: Fri, 5 Jun 2015 10:53:20 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI: Remove unnecessary #includes of <asm/pci.h>
Message-ID: <20150605015317.GB13022@verge.net.au>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2015 at 04:49:57PM -0500, Bjorn Helgaas wrote:
> In include/linux/pci.h, we already #include <asm/pci.h>, so we don't need
> to include <asm/pci.h> directly.
> 
> Remove the unnecessary includes.  All the files here already include
> <linux/pci.h>.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-alpha@vger.kernel.org
> CC: linux-mips@linux-mips.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-sh@vger.kernel.org
> CC: x86@kernel.org
> ---
>  arch/alpha/kernel/core_irongate.c |    1 -
>  arch/alpha/kernel/sys_eiger.c     |    1 -
>  arch/alpha/kernel/sys_nautilus.c  |    1 -
>  arch/mips/pci/fixup-cobalt.c      |    1 -
>  arch/mips/pci/ops-mace.c          |    1 -
>  arch/mips/pci/pci-lantiq.c        |    1 -
>  arch/powerpc/kernel/prom.c        |    1 -
>  arch/powerpc/kernel/prom_init.c   |    1 -
>  arch/sh/drivers/pci/ops-sh5.c     |    1 -
>  arch/sh/drivers/pci/pci-sh5.c     |    1 -
>  arch/x86/kernel/x86_init.c        |    1 -
>  11 files changed, 11 deletions(-)

arch/sh/drivers portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
