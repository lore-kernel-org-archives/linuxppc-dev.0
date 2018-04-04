Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBZ0xmvzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:50 +1000 (AEST)
In-Reply-To: <20180322084350.21249-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc/mm/radix: Update pte fragment count from 16 to 256
 on radix
Message-Id: <40GTBZ061Xz9s1r@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 08:43:50 UTC, "Aneesh Kumar K.V" wrote:
> Right now we use only 4K out of the 64k page allocated for the level 4 page
> table. W.r.t the performance impact due to lock contention, with ebizzy
> 
> 256 threads:
> without patch (10 runs of ./ebizzy  -m -n 1000 -s 131072 -S 100)
> median = 15678.5
> stdev = 42.1209
> 
> with patch:
> median = 15354
> stdev = 194.743
> 
> This is with THP disabled. With THP enabled the impact of the patch will be less.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fb4e5dbd44564077fa0267a59b4596

cheers
