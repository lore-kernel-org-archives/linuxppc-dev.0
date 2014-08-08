Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCD9E1A0A47
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 13:49:56 +1000 (EST)
Message-ID: <1407469782.4508.0.camel@pasglop>
Subject: Re: [PATCH v4 1/5] powerpc/eeh: Export eeh_iommu_group_to_pe()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 08 Aug 2014 13:49:42 +1000
In-Reply-To: <1407379640-13065-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407379640-13065-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-07 at 12:47 +1000, Gavin Shan wrote:
> The function is used by VFIO driver, which might be built as a
> dynamic module. So it should be exported.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Alex, are you taking this or should I ?

> ---
>  arch/powerpc/kernel/eeh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 6043879..59a64f8 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1254,6 +1254,7 @@ struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group)
>  
>  	return edev->pe;
>  }
> +EXPORT_SYMBOL_GPL(eeh_iommu_group_to_pe);
>  
>  #endif /* CONFIG_IOMMU_API */
>  
