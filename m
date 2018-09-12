Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429Sfd0p65zF3Rk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 02:58:48 +1000 (AEST)
Date: Wed, 12 Sep 2018 11:58:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
Message-ID: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The original PCI error recovery functionality was for the powerpc-specific
> IBM EEH feature.  PCIe subsequently added some similar features, including
> AER and DPC, that can be used on any architecture.
> 
> We want the generic PCI core error handling support to work with all of
> these features.  Driver error recovery callbacks should be independent of
> which feature the platform provides.
> 
> Add the generic PCI core error recovery files to the powerpc EEH
> MAINTAINERS entry so the powerpc folks will be copied on changes to the
> generic PCI error handling strategy.

I really want to make sure the powerpc folks are plugged into any PCI core
error handling discussions.  Please let me know if there's a better way
than this patch, or if there are other people who should be added.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e10ba65bfe4..d6699597fd89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
> 
