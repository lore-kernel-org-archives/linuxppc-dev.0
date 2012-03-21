Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2BFD7B6EF4
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 11:56:35 +1100 (EST)
Date: Wed, 21 Mar 2012 01:56:31 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Please pull 'next' branch of 5xxx tree
Message-ID: <20120321015631.0374755d@wker>
In-Reply-To: <20120320223017.GB6292@pengutronix.de>
References: <20120320180450.5f6dffe4@wker>
 <20120320223017.GB6292@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, 20 Mar 2012 23:30:17 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Hi,
> 
> >       powerpc/mpc52xx: setup port_config and CDM settings through DT
> 
> Can we skip this patch for 3.5? Between posting it and pushing it upstream were
> about 24 hours, so one didn't have much chance of reviewing (and no linux-next
> exposure).

Pretty much similar patch was posted nearly one year ago, so my
assumption was that people have had enough time to comment on it :-).
But I've dropped this patch from the next branch for now.

> I think the bindings leave space for questions, e.g. is it really desirable to
> have the fractional divide ratios encoded like in the bits in the register? Why
> not encode it like e.g. <11 11 11 11> (the actual divisor) or so? I could
> imagine there are examples for setting dividers somewhere. Poking values into
> registers tends to be suspicious, so I'd vote for giving all this more
> exposure.

At the end we will be poking values into registers anyway :-),
but I'm open for suggestions and discussion about them.

Thanks,
Anatolij
