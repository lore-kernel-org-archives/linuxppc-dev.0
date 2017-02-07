Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHSbn2DQczDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:15:17 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 194so10604357pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 18:15:17 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 7 Feb 2017 07:45:07 +0530
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Add MMU_FTR_KERNEL_RO to possible feature mask
Message-ID: <20170207021507.GA22303@localhost.localdomain>
References: <1486406367-31126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486406367-31126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 12:09:27AM +0530, Aneesh Kumar K.V wrote:
> Without this we will always find the feature disabled
> 
> Fixes: 984d7a1ec6 ("powerpc/mm: Fixup kernel read only mapping")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index a34c764ca8dd..e5616bf83623 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -136,6 +136,7 @@ enum {
>  		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
>  		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
>  		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
> +		MMU_FTR_KERNEL_RO |
>  #ifdef CONFIG_PPC_RADIX_MMU
>  		MMU_FTR_TYPE_RADIX |
>  #endif

Acked-by: Balbir Singh <bsingharora@gmail.com>
