Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgW1lztzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:19 +1000 (AEST)
In-Reply-To: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2,
 1/4] powerpc/mm/hugetlb: Update huge_ptep_set_access_flags to call
 __ptep_set_access_flags directly
Message-Id: <40zxgV1x0xz9s1w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-29 at 14:28:38 UTC, "Aneesh Kumar K.V" wrote:
> In a later patch, we want to update __ptep_set_access_flags take page size
> arg. This makes ptep_set_access_flags only work with mmu_virtual_psize.
> To simplify the code make huge_ptep_set_access_flags directly call
> __ptep_set_access_flags so that we can compute the hugetlb page size in
> hugetlb function.
> 
> Now that ptep_set_access_flags won't be called for hugetlb remove
> the is_vm_hugetlb_page() check and add the assert of pte lock
> unconditionally.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f069ff396d657ac7bdb5de866c3ec2

cheers
