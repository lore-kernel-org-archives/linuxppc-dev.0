Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq12t0fwKzDqBF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:09:42 +1000 (AEST)
In-Reply-To: <1460975767.5963.1.camel@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: [v2,
 1/3] powerpc: scan_features() updates incorrect bits for REAL_LE
Message-Id: <3qq12q6cy8z9t6J@ozlabs.org>
Date: Tue, 19 Apr 2016 20:09:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-18-04 at 10:36:07 UTC, Michael Ellerman wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> The REAL_LE feature entry in the ibm_pa_feature struct is missing an MMU
> feature value, meaning all the remaining elements initialise the wrong
> values.
...
> 
> Fix the code by adding the missing initialisation of the MMU feature.
> 
> Also add a comment marking CPU user feature bit 2 (0x4) as reserved. It
> would be unsafe to start using it as old kernels incorrectly set it.
> 
> Fixes: 44ae3ab3358e ("powerpc: Free up some CPU feature bits by moving out MMU-related features")
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org
> [mpe: Flesh out changelog, add comment reserving 0x4]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/6997e57d693b07289694239e52

cheers
