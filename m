Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6kQp2pmMzDvQM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 17:06:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] powerpc/iommu: use permission-specific DEVICE_ATTR
 variants
In-Reply-To: <1477769829-22230-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
 <1477769829-22230-9-git-send-email-Julia.Lawall@lip6.fr>
Date: Mon, 31 Oct 2016 17:06:58 +1100
Message-ID: <87twbt127x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall <Julia.Lawall@lip6.fr> writes:

> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 5f202a5..32f18b5 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -127,8 +127,7 @@ static ssize_t fail_iommu_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(fail_iommu, S_IRUGO|S_IWUSR, fail_iommu_show,
> -		   fail_iommu_store);
> +static DEVICE_ATTR_RW(fail_iommu);

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
