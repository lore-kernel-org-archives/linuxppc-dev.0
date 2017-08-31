Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLQ2vgnzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:14 +1000 (AEST)
In-Reply-To: <20170816123444.5202-1-clabbe.montjoie@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: powernv: Fix build error on const discarding
Message-Id: <3xjgLQ0DTHz9t1t@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-16 at 12:34:44 UTC, Corentin Labbe wrote:
> When building a random powerpc kernel I hit this build error:
>   CC      arch/powerpc/platforms/powernv/opal-imc.o
> arch/powerpc/platforms/powernv/opal-imc.c: In function « disable_nest_pmu_counters »:
> arch/powerpc/platforms/powernv/opal-imc.c:130:13: error : assignment discards « const » qualifier from pointer target type [-Werror=discarded-qualifiers]
>    l_cpumask = cpumask_of_node(nid);
>              ^
> This patch simply add const to l_cpumask to fix this issue.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6538ac30841638b2fd345725a9fd15

cheers
