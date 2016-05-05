Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0hG83P83zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 14:08:00 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id 206so33011761pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 21:08:00 -0700 (PDT)
Subject: Re: [PATCH v9 02/26] powerpc/powernv: Cleanup on pci_controller_ops
 instances
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-3-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8611128d-9654-7e95-8349-2128cf52086c@ozlabs.ru>
Date: Thu, 5 May 2016 14:07:43 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 03:41 PM, Gavin Shan wrote:
> This cleans up on below data struct instances to use tab instead of
> space indent of statement to avoid complains from scripts/checkpatch.pl.
> No logical changes introduced.
>
>   @pnv_pci_ioda_controller_ops
>   @pnv_npu_ioda_controller_ops
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


Spaces to tabs conversion is correct, aligning "=" is not to _my_ 
_personal_ _taste_.


Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 36 +++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index c5baaf3..524c9c7 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3210,31 +3210,31 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>  }
>
>  static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
> -       .dma_dev_setup = pnv_pci_dma_dev_setup,
> -       .dma_bus_setup = pnv_pci_dma_bus_setup,
> +	.dma_dev_setup		= pnv_pci_dma_dev_setup,
> +	.dma_bus_setup		= pnv_pci_dma_bus_setup,
>  #ifdef CONFIG_PCI_MSI
> -       .setup_msi_irqs = pnv_setup_msi_irqs,
> -       .teardown_msi_irqs = pnv_teardown_msi_irqs,
> +	.setup_msi_irqs		= pnv_setup_msi_irqs,
> +	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
>  #endif
> -       .enable_device_hook = pnv_pci_enable_device_hook,
> -       .window_alignment = pnv_pci_window_alignment,
> -       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
> -       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
> -       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
> -       .shutdown = pnv_pci_ioda_shutdown,
> +	.enable_device_hook	= pnv_pci_enable_device_hook,
> +	.window_alignment	= pnv_pci_window_alignment,
> +	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> +	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
> +	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
> +	.shutdown		= pnv_pci_ioda_shutdown,
>  };
>
>  static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
> -	.dma_dev_setup = pnv_pci_dma_dev_setup,
> +	.dma_dev_setup		= pnv_pci_dma_dev_setup,
>  #ifdef CONFIG_PCI_MSI
> -	.setup_msi_irqs = pnv_setup_msi_irqs,
> -	.teardown_msi_irqs = pnv_teardown_msi_irqs,
> +	.setup_msi_irqs		= pnv_setup_msi_irqs,
> +	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
>  #endif
> -	.enable_device_hook = pnv_pci_enable_device_hook,
> -	.window_alignment = pnv_pci_window_alignment,
> -	.reset_secondary_bus = pnv_pci_reset_secondary_bus,
> -	.dma_set_mask = pnv_npu_dma_set_mask,
> -	.shutdown = pnv_pci_ioda_shutdown,
> +	.enable_device_hook	= pnv_pci_enable_device_hook,
> +	.window_alignment	= pnv_pci_window_alignment,
> +	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> +	.dma_set_mask		= pnv_npu_dma_set_mask,
> +	.shutdown		= pnv_pci_ioda_shutdown,
>  };
>
>  static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>


-- 
Alexey
