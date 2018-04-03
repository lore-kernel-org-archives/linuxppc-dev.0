Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5l6BG3zF28r
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:39 +1000 (AEST)
In-Reply-To: <20180322210318.21349-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Fix always false comparison against
 MMU_NO_CONTEXT
Message-Id: <40Fv5l3r5rz9s0b@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 21:03:18 UTC, Mathieu Malaterre wrote:
> In commit 9690c1574268 ("powerpc/mm/radix: Fix always false comparison
> against MMU_NO_CONTEXT") an issue was discovered where `mm->context.id` was
> being truncated to an `unsigned int`, while the PID is actually an
> `unsigned long`. Update the earlier patch by fixing one remaining
> occurrence. Discovered during a compilation with W=1:
> 
>   arch/powerpc/mm/tlb-radix.c:702:19: error: comparison is always false due to limited range of data type [-Werror=type-limits]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/19e68b2aec3c0a2bd770d3c358a296

cheers
