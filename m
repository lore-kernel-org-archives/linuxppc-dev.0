Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdT3n1xzF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:25 +1000 (AEST)
In-Reply-To: <20180813054457.13241-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2] powerpc/mm/book3s/radix: Add mapping statistics
Message-Id: <41ptdT1q0Qz9sCn@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-13 at 05:44:57 UTC, "Aneesh Kumar K.V" wrote:
> Add statistics that show how memory is mapped within the kernel linear mapping.
> This is similar to commit 37cd944c8d8f ("s390/pgtable: add mapping statistics")
> 
> We don't do this with Hash translation mode. Hash uses one size (mmu_linear_psize)
> to map the kernel linear mapping and we print the linear psize during boot as
> below.
> 
> "Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24"
> 
> A sample output looks like:
> 
> DirectMap4k:           0 kB
> DirectMap64k:       18432 kB
> DirectMap2M:     1030144 kB
> DirectMap1G:    11534336 kB
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a2dc009afa9ae8b92305be77286765

cheers
