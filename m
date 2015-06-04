Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B8F61A0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 22:15:38 +1000 (AEST)
In-Reply-To: <1432813957-46874-4-git-send-email-dingel@linux.vnet.ibm.com>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/5] mm/hugetlb: remove arch_prepare/release_hugepage from arch
 headers
Message-Id: <20150604121538.58C3C140273@ozlabs.org>
Date: Thu,  4 Jun 2015 22:15:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-28-05 at 11:52:35 UTC, Dominik Dingel wrote:
> Nobody used these hooks so they were removed from common code,
> and can now be removed from the architectures.
> 
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 4bbd3c8..7eac89b 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -168,15 +168,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return *ptep;
>  }
>  
> -static inline int arch_prepare_hugepage(struct page *page)
> -{
> -	return 0;
> -}
> -
> -static inline void arch_release_hugepage(struct page *page)
> -{
> -}
> -
>  static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
