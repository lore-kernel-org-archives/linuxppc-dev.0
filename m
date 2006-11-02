Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 671E267D2A
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:22:52 +1100 (EST)
Subject: Re: [patch 05/16] powerpc: remove ifdef
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125625.828393000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125625.828393000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:22:47 +1100
Message-Id: <1162506167.10630.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 13:56 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (powerpc-include-asm-powerpc-pci_h-remove-ifdef.diff)
> current kernels always have one of CONFIG_PPC_MULTIPLATFORM
> or CONFIG_PPC32 defined, so remove bogus ifdef
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: linux-2.6/include/asm-powerpc/pci.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/pci.h
> +++ linux-2.6/include/asm-powerpc/pci.h
> @@ -238,12 +238,10 @@ extern pgprot_t	pci_phys_mem_access_prot
>  					 unsigned long size,
>  					 pgprot_t prot);
>  
> -#if defined(CONFIG_PPC_MULTIPLATFORM) || defined(CONFIG_PPC32)
>  #define HAVE_ARCH_PCI_RESOURCE_TO_USER
>  extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
>  				 const struct resource *rsrc,
>  				 resource_size_t *start, resource_size_t *end);
> -#endif /* CONFIG_PPC_MULTIPLATFORM || CONFIG_PPC32 */
>  
>  #endif	/* __KERNEL__ */
>  #endif /* __ASM_POWERPC_PCI_H */
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
