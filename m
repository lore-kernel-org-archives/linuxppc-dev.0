Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHPXw49l3zDvXg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 19:57:20 +1100 (AEDT)
From: mpe@ellerman.id.au
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, benh@au1.ibm.com, michael.neuling@au1.ibm.com,
 paulus@au1.ibm.com, "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] mm: move vma_is_anonymous check within
 pmd_move_must_withdraw
In-Reply-To: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 14 Nov 2016 19:57:16 +1100
Message-ID: <87inrqiglv.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Architectures like ppc64 want to use page table deposit/withraw
> even with huge pmd dax entries. Allow arch to override the
> vma_is_anonymous check by moving that to pmd_move_must_withdraw
> function
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  3 ++-
>  include/asm-generic/pgtable.h                | 12 ------------
>  mm/huge_memory.c                             | 18 ++++++++++++++++--
>  3 files changed, 18 insertions(+), 15 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
