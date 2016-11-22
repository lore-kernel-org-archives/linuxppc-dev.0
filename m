Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN65z2RZbzDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:38:47 +1100 (AEDT)
In-Reply-To: <20161118030856.12445-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [v3] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9 DD1
Message-Id: <3tN65z0qKLz9srZ@ozlabs.org>
Date: Tue, 22 Nov 2016 11:38:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-18 at 03:08:56 UTC, Michael Neuling wrote:
> On POWER9 DD1, when we do a local TLB invalidate we also need to explicitly
> invalidate the ERAT.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/96ed1fe511a8b4948e53f3bad431d8

cheers
