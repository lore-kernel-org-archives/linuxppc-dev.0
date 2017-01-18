Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlc06pWzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:20 +1100 (AEDT)
In-Reply-To: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org,
 Chris Smart <csmart@ozlabs.au.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/hugetlb: Don't panic if we don't find the default huge
 page size
Message-Id: <3v3Qlb6kHnz9t1Q@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-13 at 14:04:11 UTC, "Aneesh Kumar K.V" wrote:
> generic hugetlbfs can handle that condition correctly. With HPAGE_SHIFT = 0
> we get
> [0.241333] hugetlbfs: disabling because there are no supported hugepage sizes
> 
> bash-4.2# echo 30 > /proc/sys/vm/nr_hugepages
> bash: echo: write error: Operation not supported
> 
> Fixes: "powerpc: get hugetlbpage handling more generic"
> Reported-by: Chris Smart <csmart@ozlabs.au.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-By: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ff8b85796dad5de869dc29903c9566

cheers
