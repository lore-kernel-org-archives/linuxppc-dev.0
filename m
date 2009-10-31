Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F345B7C5A
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 07:48:12 +1100 (EST)
Subject: Re: mpc512x/clock: fix clk_get logic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20091031130131.GA23009@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<1256939657.6372.81.camel@pasglop>
	<20091031130131.GA23009@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 01 Nov 2009 07:48:02 +1100
Message-ID: <1257022082.7907.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-31 at 14:01 +0100, Wolfram Sang wrote:
> Hello Ben,
> 
> > Have you considered switching to my proposed device-tree based clock
> > reprentation ?
> 
> You mean this one?
> 
> http://patchwork.ozlabs.org/patch/31551/
> 
> Sorry, I have missed it up to now :(
> 
> While I think (after one glimpse) this moves things into the right direction,
> my priority at the moment is to get the mscan driver working on 512x (and then
> to mainline). For that, I needed the patch I posted. I hope I can have another
> look at your proposal later on, it looks really worth it.
> 
> Until then I'd propose to consider this patch as it fixes a bug in clock
> assignment. But I leave the final decision to you maintainers, of course.

Sure I don't have major objections against your patch (though who is
formally mpc512x maintainer to ack it ?), I just wanted to make sure you
had a look at my proposal since this is almost the only platform to use
the clock API today in arch/powerpc.

Cheers,
Ben.
