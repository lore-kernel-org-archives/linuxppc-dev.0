Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzG26rbnzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:20:10 +1100 (AEDT)
In-Reply-To: <1486346716.4850.82.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Update ERAT flushes when invalidating TLB
Message-Id: <3vJzG21L4cz9s7n@ozlabs.org>
Date: Fri, 10 Feb 2017 00:20:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-06 at 02:05:16 UTC, Benjamin Herrenschmidt wrote:
> Three tiny changes to the ERAT flushing logic: First don't make
> it depend on DD1. It hasn't been decided yet but we might run
> DD2 in a mode that also requires explicit flushes for performance
> reasons so make it unconditional. We also add a missing isync, and
> finally remove the flush from _tlbiel_va as it is only necessary
> for congruence-class invalidations (PID, LPID and full TLB), not
> targetted invalidations.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/90c1e3c2fafec57fcb55b5d69bcf29

cheers
