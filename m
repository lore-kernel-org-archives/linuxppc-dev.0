Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3D1JJczDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:52 +1000 (AEST)
In-Reply-To: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/mm/hash: Remove the superfluous bitwise operation
 when find hpte group
Message-Id: <41Zg3C6NL4z9ryn@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-29 at 08:36:29 UTC, "Aneesh Kumar K.V" wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> When computing the starting slot number for a hash page table group we used
> to do this
> hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
> 
> Multiplying with 8 (HPTES_PER_GROUP) imply the last three bits are 0. Hence we
> really don't need to clear then separately.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1531cff44b5bb30c899404c044805e

cheers
