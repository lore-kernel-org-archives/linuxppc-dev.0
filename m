Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGX5G2bzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:44 +1000 (AEST)
In-Reply-To: <20170919104553.5146-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/sstep: Fix issues with set_cr0()
Message-Id: <3xyKGX3RVdz9sPm@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-19 at 10:45:52 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> set_cr0() broke when we changed analyse_instr() to not modify the
> register state. Instead of looking at regs->gpr[x] which has not
> been updated yet, we need to look at op->val.
> 
> Fixes: 3cdfcbfd32b9 ("powerpc: Change analyse_instr so it doesn't modify *regs")
> Signed-off-by: Anton Blanchard <anton@samba.org>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ad47ff3e33503e0969db2d4f9a4094

cheers
