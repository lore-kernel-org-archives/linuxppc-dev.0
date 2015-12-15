Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC2811A0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:44:40 +1100 (AEDT)
Date: Tue, 15 Dec 2015 17:44:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20151215174439.4fd3177c@canb.auug.org.au>
In-Reply-To: <20151215165342.15bb4526@canb.auug.org.au>
References: <20151215165342.15bb4526@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Tue, 15 Dec 2015 16:53:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 8b929e531758..4e69d9a273ed 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -48,9 +43,8 @@
>  /*
>   * set of bits not changed in pmd_modify.
>   */
> -#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
> -			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
> -			 _PAGE_THP_HUGE | _PAGE_PTE)
> +#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY |
                                                                           ^
I missed a backslash here which I fixed up in my tree.

> +			 _PAGE_ACCESSED | _PAGE_THP_HUGE | _PAGE_PTE)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
