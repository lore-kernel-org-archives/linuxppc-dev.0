Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1b0QSJzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:35 +1100 (AEDT)
In-Reply-To: <20170104024912.8214-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org,
 Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/4k: don't allocate larger pmd page table for 4k
Message-Id: <3v8g1Z6xgZz9t6g@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-04 at 02:49:12 UTC, "Aneesh Kumar K.V" wrote:
> We now support THP with both 64k and 4K page size configuration
> for radix. (hash only support THP with 64K page size). Hence we
> will have CONFIG_TRANSPARENT_HUGEPAGE enabled for both PPC_64K
> and PPC_4K config. Since we only need large pmd page table
> with hash configuration (to store the slot information
> in the second half of the table) restrict the large pmd page table
> to THP and 64K configs.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8ad43336b5c1ad9ac945148cb5e26a

cheers
