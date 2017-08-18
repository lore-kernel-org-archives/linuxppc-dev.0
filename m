Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjcf6vL4zDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:50:58 +1000 (AEST)
In-Reply-To: <20170728050127.28338-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v4,
 1/3] mm/hugetlb: Allow arch to override and call the weak function
Message-Id: <3xYjcf4rldz9t30@ozlabs.org>
Date: Fri, 18 Aug 2017 22:50:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-28 at 05:01:25 UTC, "Aneesh Kumar K.V" wrote:
> When running in guest mode ppc64 supports a different mechanism for hugetlb
> allocation/reservation. The LPAR management application called HMC can
> be used to reserve a set of hugepages and we pass the details of
> reserved pages via device tree to the guest. (more details in
> htab_dt_scan_hugepage_blocks()) . We do the memblock_reserve of the range
> and later in the boot sequence, we add the reserved range to huge_boot_pages.
> 
> But to enable 16G hugetlb on baremetal config (when we are not running as guest)
> we want to do memblock reservation during boot. Generic code already does this
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e24a1307ba1f99fc62a0bd61d5e87f

cheers
