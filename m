Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjcq3VRRzDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:51:07 +1000 (AEST)
In-Reply-To: <620568b89e995ed57f03da41857fb37584766a69.1502931841.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/1] selftests/powerpc: Improve tm-resched-dscr
Message-Id: <3xYjcp27Hlz9t3s@ozlabs.org>
Date: Fri, 18 Aug 2017 22:51:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-17 at 01:06:47 UTC, Sam bobroff wrote:
> The tm-resched-dscr self test can, in some situations, run for
> several minutes before being successfully interrupted by the context
> switch it needs in order to perform the test. This often seems to
> occur when the test is being run in a virtual machine.
> 
> Improve the test by running it under eat_cpu() to guarantee
> contention for the CPU and increase the chance of a context switch.
> 
> In practice this seems to reduce the test time, in some cases, from
> more than two minutes to under a second.
> 
> Also remove the "progress dots" so that if the test does run for a
> long time, it doesn't produce large amounts of unnecessary output.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/99597ceda00b57396a176e08bd5e5c

cheers
