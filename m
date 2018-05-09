Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gzyc3RHrzF2SQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:59:04 +1000 (AEST)
In-Reply-To: <c50df60c9ca8309df56e0eb9a00072c154897764.1525439237.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [1/2] powerpc/trace elfv1: Update syscall name matching logic
Message-Id: <40gzyc2YY6z9s5b@ozlabs.org>
Date: Thu, 10 May 2018 00:59:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-04 at 13:14:24 UTC, "Naveen N. Rao" wrote:
> On powerpc64 ABIv1, we are enabling syscall tracing for only ~20
> syscalls. This is due to commit e145242ea0df6 ("syscalls/core,
> syscalls/x86: Clean up syscall stub naming convention") which has
> changed the syscall entry wrapper prefix from "SyS" to "__se_sys".
> 
> Update the logic for ABIv1 to not just skip the initial dot, but also
> the "__se_sys" prefix.
> 
> Fixes: commit e145242ea0df6 ("syscalls/core, syscalls/x86: Clean up syscall stub naming convention")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0b7758aaf6543b9a10c8671db559e9

cheers
