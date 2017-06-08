Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsMY27RqzDqPd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:07:37 +1000 (AEST)
In-Reply-To: <20170529062644.21634-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: machine check handle ifetch from foreign real
 address for POWER9
Message-Id: <3wjsMY1LKcz9s8Y@ozlabs.org>
Date: Thu,  8 Jun 2017 14:07:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 06:26:44 UTC, Nicholas Piggin wrote:
> The i-side 0111b case was missed by 7b9f71f974 ("powerpc/64s: POWER9
> machine check handler").
> 
> It is possible to trigger this exception by branching to a foreign real
> address (bits [8:12] != 0) with instruction relocation off, and verify
> the exception cause is found after this patch.
> 
> Fixes: 7b9f71f974 ("powerpc/64s: POWER9 machine check handler")
> Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/90df4bfb4d9e00a1ab6885900b808b

cheers
