Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9FC11A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 14:37:16 +1000 (AEST)
Message-ID: <1437021436.28475.7.camel@ellerman.id.au>
Subject: Re: [patch 00/20] powerpc: Interrupt cleanups and API change
 preparation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Thu, 16 Jul 2015 14:37:16 +1000
In-Reply-To: <20150713135648.540293392@linutronix.de>
References: <20150713135648.540293392@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-13 at 20:50 +0000, Thomas Gleixner wrote:
> The following patch series contains the following changes:
> 
>     - Consolidation of chained interrupt handler setup/removal
> 
>     - Switch to functions which avoid a redundant interrupt
>       descriptor lookup
> 
>     - Preparation of interrupt flow handlers for the 'irq' argument
>       removal
> 
> The series has no dependencies ...

But I assume you have work that will depend on it? So you're going to merge it
via your tree at least I assume?

> ... and is also available as a git branch for your convenience:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/arm

I can't find this.

Did you mean irq/ppc or irq/powerpc maybe? I can't find those either.

> If you want me to carry the patches in the irq/core branch of tip,
> please let me know.

cheers
