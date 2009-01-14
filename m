Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 786A8DE10C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:38:41 +1100 (EST)
Date: Wed, 14 Jan 2009 14:38:41 -0800 (PST)
Message-Id: <20090114.143841.153393716.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [PATCH] phylib: Fix Freescale TBI PHY detection
From: David Miller <davem@davemloft.net>
In-Reply-To: <4DDB8462-ACB6-494A-A1CB-4F56668A4EE1@freescale.com>
References: <20090113160513.GA22083@oksana.dev.rtsoft.ru>
	<20090114150332.GA839@oksana.dev.rtsoft.ru>
	<4DDB8462-ACB6-494A-A1CB-4F56668A4EE1@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, giulio.benetti@micronovasrl.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Wed, 14 Jan 2009 12:20:35 -0600

> On Jan 14, 2009, at 9:03 AM, Anton Vorontsov wrote:
> >>
> >> There is one thing I don't actually understand though...
> >>
> >> Andy, were you testing the TBI support on a hardware where PHY ID
> >> != 0x0 or maybe your TBI PHY support patch (commit b31a1d8b41513b,
> >> dated Tue Dec 16 15:29:15 2008) was based on a bit outdated kernel
> >> version? Because according to the git timestamps, the TBI support
> >> was not working since the submission.
> >>
> >> Just in case, the hardware I'm seeing the PHY ID == 0x0 is
> >> MPC8378E-MDS.
> >
> > I think I got it. Probably the TBI support patch was based on the
> > powerpc.git next, and the commit that broke the TBI support
> > was in the net-next-2.6 tree.
> >
> > That explains why nobody noticed the issue.
> 
> 
> Yeah, I dropped the ball.  I saw the patch go in, thought that might break something, but I didn't find time to look into it.  Thanks for finding and reverting this bug.
> 
> Acked-by: Andy Fleming <afleming@freescale.com>

Patch applied, thanks everyone.

I was worried when I applied the patch causing this, that some
device would in fact trigger that specific test.  Turns out
my worries were warranted :)
