Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 404722C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 07:28:06 +1000 (EST)
Message-ID: <1370986074.8250.133.camel@pasglop>
Subject: Re: [PATCH] powerpc/iommu: Remove unused pci_iommu_init() and
 pci_direct_iommu_init()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Jun 2013 07:27:54 +1000
In-Reply-To: <20130611195705.17794.68833.stgit@bhelgaas-glaptop>
References: <20130611195705.17794.68833.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-11 at 13:57 -0600, Bjorn Helgaas wrote:
> pci_iommu_init() and pci_direct_iommu_init() are not referenced anywhere,
> so remove them.

Ah indeed, some old stuff...

Thanks,
Ben.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/iommu.h |    7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index cbfe678..e670f73 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -125,13 +125,6 @@ extern void iommu_init_early_pSeries(void);
>  extern void iommu_init_early_dart(void);
>  extern void iommu_init_early_pasemi(void);
>  
> -#ifdef CONFIG_PCI
> -extern void pci_iommu_init(void);
> -extern void pci_direct_iommu_init(void);
> -#else
> -static inline void pci_iommu_init(void) { }
> -#endif
> -
>  extern void alloc_dart_table(void);
>  #if defined(CONFIG_PPC64) && defined(CONFIG_PM)
>  static inline void iommu_save(void)
