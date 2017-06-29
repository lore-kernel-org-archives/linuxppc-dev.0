Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKL2rD2zDr57
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:10 +1000 (AEST)
In-Reply-To: <20170614130241.19865-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/3] cpuidle: powerpc: cpuidle set polling before enabling irqs
Message-Id: <3wyzKL1g2Vz9s65@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 13:02:39 UTC, Nicholas Piggin wrote:
> local_irq_enable can cause interrupts to be taken which could
> take significant amount of processing time. The idle process
> should set its polling flag before this, so another process that
> wakes it during this time will not have to send an IPI.
> 
> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3fc5ee927ff4ffed6aa2fcd44d2fbf

cheers
