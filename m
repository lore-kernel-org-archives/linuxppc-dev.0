Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SZ30SjzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:02 +1000 (AEST)
In-Reply-To: <20180911030756.19583-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/tm: Fix HFSCR bit for no suspend case
Message-Id: <42G3SX6pJxz9sBy@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-11 at 03:07:56 UTC, Michael Neuling wrote:
> Currently on P9N DD2.1 we end up taking infinite TM facility
> unavailable exceptions on the first TM usage by userspace.
> 
> In the special case of TM no suspend (P9N DD2.1), Linux is told TM is
> off via CPU dt-ftrs but told to (partially) use it via
> OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM] will be off from
> dt-ftrs but we need to turn it on for the no suspend case.
> 
> This patch fixes this by enabling HFSCR TM in this case.
> 
> Cc: stable@vger.kernel.org # 4.15+
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dd9a8c5a87395b6f05552c3b44e42f

cheers
