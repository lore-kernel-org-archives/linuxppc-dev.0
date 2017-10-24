Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmBJ1vnszDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:56 +1100 (AEDT)
In-Reply-To: <20171016071100.8497-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Drop unneeded NULL check
Message-Id: <3yLmBH6ss4z9s76@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-16 at 07:11:00 UTC, "Aneesh Kumar K.V" wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> We call these functions with non-NULL mm or vma. Hence we can skip the NULL
> check in these functions. We also remove now unused function
> __local_flush_hugetlb_page().
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6773027205ea4ccf17055d7f0a0cd8

cheers
