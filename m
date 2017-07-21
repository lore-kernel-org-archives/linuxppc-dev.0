Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDSmc0sdjzDqts
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 21:13:04 +1000 (AEST)
In-Reply-To: <20170710061938.22513-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <masriniv@in.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: POWER9 PMU interrupt after idle workaround
Message-Id: <3xDSmb5pvMz9t1K@ozlabs.org>
Date: Fri, 21 Jul 2017 21:13:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-10 at 06:19:38 UTC, Nicholas Piggin wrote:
> POWER9 DD2 can see spurious PMU interrupts after state-loss idle in
> some conditions.
> 
> A solution is to save and reload MMCR0 over state-loss idle.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/101dd590a7fa37954540cf3149a1c5

cheers
