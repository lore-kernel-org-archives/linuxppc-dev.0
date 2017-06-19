Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqvD3c3gzDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:43 +1000 (AEST)
In-Reply-To: <20170613130557.26315-6-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [05/13] powerpc/64s: interrupt replay balance the return branch
 predictor
Message-Id: <3wrqvC4406z9sCX@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 13:05:49 UTC, Nicholas Piggin wrote:
> The __replay_interrupt code is branched to with bl, but the caller is
> returned to directly with rfid from the interrupt.
> 
> Instead, rfid to a stub that returns to the caller with blr, which
> should keep the return branch predictor balanced.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b48bbb82e2b83537c500417d60218a

cheers
