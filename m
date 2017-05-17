Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTg13GQ1zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:37 +1000 (AEST)
In-Reply-To: <1494580926-17590-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powernv:idle: Set NAPSTATELOST after recovering paca on P9 DD1
Message-Id: <3wSTg11zfMz9s8F@ozlabs.org>
Date: Wed, 17 May 2017 19:34:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-12 at 09:22:06 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
> from a stop on P9 DD1") promises to set the NAPSTATELOST bit in paca
> after recovering the correct paca for the thread waking up from stop1
> on DD1, so that the GPRs can be correctly restored on the stop exit
> path. However, it loads the value 1 into r3, but stores the value in
> r0 into NAPSTATELOST(r13).
> 
> Fix this by correctly set the NAPSTATELOST bit in paca after
> recovering the paca on POWER9 DD1.
> 
> Fixes: commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
> from a stop on P9 DD1")
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bbb075ddf7d58762040ca413ad82e9

cheers
