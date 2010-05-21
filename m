Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85801B7D2D
	for <linuxppc-dev@ozlabs.org>; Sat, 22 May 2010 08:38:24 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20100521130417.GB27829@pengutronix.de>
References: <1274433088.1931.63.camel@pasglop>
	<20100521130417.GB27829@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 22 May 2010 08:38:13 +1000
Message-ID: <1274481493.1931.98.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-21 at 15:04 +0200, Wolfram Sang wrote:
> > Wolfram Sang (4):
> >       powerpc/pmac: Fix dangling pointers
> >       i2c/mpc: Drop NO_IRQ
> >       i2c/cpm: Drop NO_IRQ
> >       i2c/ibm-iic: Drop NO_IRQ
> 
> Sorry for the confusion, but the other Ben (Dooks) has pushed those
> NO_IRQ-thigies meanwhile.

That shouldn't be a problem. git or Linus should sort it out easily :-)
I did a test merge before sending the pull request and there was nothing
it wouldn't resolve automatically.

Cheers,
Ben.
