Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Cb5x1g5JzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 22:56:05 +1000 (AEST)
In-Reply-To: <20180614103152.7344-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/hash/4k: Free hugetlb page table caches correctly.
Message-Id: <41Cb5w5R0gz9s31@ozlabs.org>
Date: Sat, 23 Jun 2018 22:56:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-14 at 10:31:52 UTC, "Aneesh Kumar K.V" wrote:
> With 4k page size for hugetlb we allocate hugepage directories from its on slab
> cache. With patch 0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
> we missed to free these allocated hugepd tables.
> 
> Update pgtable_free to handle hugetlb hugepd directory table.
> 
> Fixes:  0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fadd03c615922d8521a2e76d4ba233

cheers
