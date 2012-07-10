Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BFF72C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 17:49:47 +1000 (EST)
Message-ID: <1341906580.2561.13.camel@pasglop>
Subject: Re: [PATCH] More fixes for lazy IRQ vs. idle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Tue, 10 Jul 2012 17:49:40 +1000
In-Reply-To: <21083.1341900615@neuling.org>
References: <1341891538.2561.10.camel@pasglop> <21083.1341900615@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-10 at 16:10 +1000, Michael Neuling wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Looks like we still have issues with pSeries and Cell idle code
> > vs. the lazy irq state. In fact, the reset fixes that went upstream
> > are exposing the problem more by causing BUG_ON() to trigger (which
> > this patch turns into a WARN_ON instead).
> 
> Do we need to cc stable for 3.4 or is this new stuff only effecting us
> since the 3.5 merge window?

That's probably stable business, I'll check that before I send it to
Linus.

Cheers,
Ben.
