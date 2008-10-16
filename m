Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A5D2FDDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 06:23:49 +1100 (EST)
Date: Thu, 16 Oct 2008 12:23:25 -0700 (PDT)
Message-Id: <20081016.122325.188129775.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] i2c-cpm: Suppress autoprobing for devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <FC91562A-D6B4-4E62-A5EA-43171A80B766@kernel.crashing.org>
References: <20081016111300.GC3432@pengutronix.de>
	<FC91562A-D6B4-4E62-A5EA-43171A80B766@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 16 Oct 2008 11:09:30 -0500

> 
> On Oct 16, 2008, at 6:13 AM, Wolfram Sang wrote:
> 
> >
> > Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also remove
> > automatic probing for this i2c controller. Might need updates to dts files
> > using it.
> >
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> > drivers/i2c/busses/i2c-cpm.c |    1 -
> > 1 file changed, 1 deletion(-)
> 
> The i2c list should be CC'd.  Jean should pick this up.

Don't bother, he'll just argue with you about the fact that class
based probing should be maintained.

He's doing exactly that with me right now.

I think the powerpc folks are doing exactly the right thing by merging
their I2C changes directly to Linus.  Please just continue doing this.

That's what I should have done with my sparc stuff, I'm being punished
now for having sent my changes to "the right place". :-/
