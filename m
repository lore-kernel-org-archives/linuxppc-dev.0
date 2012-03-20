Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F0F3EB6EE6
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 10:32:36 +1100 (EST)
Message-ID: <1332286341.2982.26.camel@pasglop>
Subject: Re: Please pull 'next' branch of 5xxx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 21 Mar 2012 10:32:21 +1100
In-Reply-To: <20120320223017.GB6292@pengutronix.de>
References: <20120320180450.5f6dffe4@wker>
 <20120320223017.GB6292@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Anatolij Gustschin <agust@denx.de>,
 Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-03-20 at 23:30 +0100, Wolfram Sang wrote:
> Hi,
> 
> >       powerpc/mpc52xx: setup port_config and CDM settings through DT
> 
> Can we skip this patch for 3.5? Between posting it and pushing it upstream were
> about 24 hours, so one didn't have much chance of reviewing (and no linux-next
> exposure).
> 
> I think the bindings leave space for questions, e.g. is it really desirable to
> have the fractional divide ratios encoded like in the bits in the register? Why
> not encode it like e.g. <11 11 11 11> (the actual divisor) or so? I could
> imagine there are examples for setting dividers somewhere. Poking values into
> registers tends to be suspicious, so I'd vote for giving all this more
> exposure.

I'll drop it from what I merge, thanks.

Anatolij, Can you organize with Stephen (CC) so that you tree is part of
linux-next for the next cycle ? Either that or make sure you send me
pull requests really early :-)

Cheers,
Ben.
