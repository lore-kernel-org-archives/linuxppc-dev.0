Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y703c5yZ9zDrBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:22:20 +1100 (AEDT)
In-Reply-To: <1506488151-9825-1-git-send-email-jk@ozlabs.org>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Meng YK Li <shlimeng@cn.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: Fix action argument for cpufeatures-based TLB flush
Message-Id: <3y703c5JmPz9t43@ozlabs.org>
Date: Thu,  5 Oct 2017 15:22:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-27 at 04:55:51 UTC, Jeremy Kerr wrote:
> Commit 41d0c2ecde introduced calls to __flush_tlb_power[89] from the
> cpufeatures code, specifying the number of sets to flush.
> 
> However, these functions take an action argument, not a number of sets.
> This means we hit the BUG() in __flush_tlb_{206,300} when using
> cpufeatures-style configuration.
> 
> This change passes TLB_INVAL_SCOPE_GLOBAL instead.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> CC: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3b7af5c0fd9631762d1c4d7b4cee76

cheers
