Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRc144HKHzDr4P
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 16:17:44 +1100 (AEDT)
In-Reply-To: <20171025071653.GB25140@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nick Piggin <npiggin@au1.ibm.com>,
 Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: powerpc: Fix check for copy/paste instructions in alignment
 handler
Message-Id: <3yRc1333nsz9t3C@ozlabs.org>
Date: Wed,  1 Nov 2017 16:17:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-25 at 07:16:53 UTC, Paul Mackerras wrote:
> Commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> when possible", 2017-06-09) changed the definition of PPC_INST_COPY
> and in so doing inadvertently broke the check for copy/paste
> instructions in the alignment fault handler.  The check currently
> matches no instructions.
> 
> This fixes it by ANDing both sides of the comparison with the mask.
> 
> Fixes: 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> when possible")
> Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/158f19698b594eb8a1bdf7d7937617

cheers
