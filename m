Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB7322C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 16:10:42 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id rr13so6093276pbb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 21:10:39 -0800 (PST)
Message-ID: <52B91747.7090309@ozlabs.ru>
Date: Tue, 24 Dec 2013 16:10:31 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] iommu: Add empty stub for iommu_group_get_by_id()
References: <1385016074-17026-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1385016074-17026-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2013 05:41 PM, Alexey Kardashevskiy wrote:
> Almost every function in include/linux/iommu.h has an empty stub
> but the iommu_group_get_by_id() did not get one by mistake.
> 
> This adds an empty stub for iommu_group_get_by_id() for IOMMU_API
> disabled config.

Ping?


> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/linux/iommu.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7ea319e..3c7903d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -245,6 +245,11 @@ static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>  	return NULL;
>  }
>  
> +static inline struct iommu_group *iommu_group_get_by_id(int id)
> +{
> +	return NULL;
> +}
> +
>  static inline void iommu_domain_free(struct iommu_domain *domain)
>  {
>  }
> 


-- 
Alexey
