Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40717S5vcBzF0Vs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 22:11:16 +1100 (AEDT)
In-Reply-To: <20180322222906.22084-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [1/2] powerpc/mm: Add tracking of the number of coprocessors
 using a context
Message-Id: <40717R5Zksz9s0y@ozlabs.org>
Date: Fri, 23 Mar 2018 22:11:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 22:29:05 UTC, Balbir Singh wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Currently, when using coprocessors (which use the Nest MMU), we
> simply increment the active_cpu count to force all TLB invalidations
> to be come broadcast.
> 
> Unfortunately, due to an errata in POWER9, we will need to know
> more specifically that coprocessors are in use.
> 
> This maintains a separate copros counter in the MMU context for
> that purpose.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Tested-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/aff6f8cb3e2170b9e58b0932bce7bf

cheers
