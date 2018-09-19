Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FN8N49wdzF3JW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 11:49:40 +1000 (AEST)
Message-ID: <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
From: Russell Currey <ruscur@russell.cc>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, oohall@gmail.com, sbobroff@linux.ibm.com
In-Reply-To: <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Sep 2018 11:49:26 +1000
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-18 at 16:58 -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The original PCI error recovery functionality was for the powerpc-specific
> > IBM EEH feature.  PCIe subsequently added some similar features, including
> > AER and DPC, that can be used on any architecture.
> > 
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent of
> > which feature the platform provides.
> > 
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I applied the following to for-linus for v4.19.  Russell, if you want
> to be removed, let me know and I'll do that.

Oliver's email address for kernel stuff is oohall@gmail.com, I think benh has been
CCing his IBM address.  But other than that,

Acked-by: Russell Currey <ruscur@russell.cc>

Thanks for this, Bjorn.

- Russell

> 
> commit 3fed0e04026c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Sep 12 11:55:26 2018 -0500
> 
>     MAINTAINERS: Update PPC contacts for PCI core error handling
>     
>     The original PCI error recovery functionality was for the powerpc-specific
>     IBM EEH feature.  PCIe subsequently added some similar features, including
>     AER and DPC, that can be used on any architecture.
>     
>     We want the generic PCI core error handling support to work with all of
>     these features.  Driver error recovery callbacks should be independent of
>     which feature the platform provides.
>     
>     Add the generic PCI core error recovery files to the powerpc EEH
>     MAINTAINERS entry so the powerpc folks will be copied on changes to the
>     generic PCI error handling strategy.
>     
>     Add Sam and Oliver as maintainers for this area.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..f23244003836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11203,8 +11203,14 @@ F:	tools/pci/
>  
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
> +M:	Sam Bobroff <sbobroff@linux.ibm.com>
> +M:	Oliver O'Halloran <oliveroh@au1.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
