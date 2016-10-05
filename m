Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzx3M4ZzDrNK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
In-Reply-To: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, cyrilbur@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: During context switch, check before setting mm_cpumask
Message-Id: <3spfzx28DDz9sCg@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-10 at 06:40:29 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> During context switch, switch_mm() sets our current CPU in mm_cpumask.
> We can avoid this atomic sequence in most cases by checking before
> setting the bit.
> 
> Testing on a POWER8 using our context switch microbenchmark:
> 
> tools/testing/selftests/powerpc/benchmarks/context_switch \
> 	--process --no-fp --no-altivec --no-vector
> 
> Performance improves 2%.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bb85fb5803270c52863b983596c2a0

cheers
