Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNQyy22YfzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 20:19:38 +1000 (AEST)
In-Reply-To: <20170720015322.24307-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <masriniv@in.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: POWER9 PMU stops after idle workaround
Message-Id: <3xNQyy1Ck3z9s7v@ozlabs.org>
Date: Thu,  3 Aug 2017 20:19:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-20 at 01:53:22 UTC, Nicholas Piggin wrote:
> POWER9 DD2 PMU can stop after a state-loss idle in some conditions.
> 
> A solution is to set then clear MMCRA[60] after wake from state-loss
> idle.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bdd21ddb919d28f9c62cdc6286cac9

cheers
