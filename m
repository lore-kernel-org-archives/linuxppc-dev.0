Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D02ADDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:08:52 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3MF8j2e012586
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:08:45 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3MF8jpm019015
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:08:45 -0500 (CDT)
Date: Tue, 22 Apr 2008 10:08:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Message-ID: <20080422150844.GA15474@ld0162-tx32.am.freescale.net>
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<200804181334.34229.laurentp@cse-semaphore.com>
	<20080421175627.GD4134@ld0162-tx32.am.freescale.net>
	<200804221055.09038.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804221055.09038.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 10:55:06AM +0200, Laurent Pinchart wrote:
> On Monday 21 April 2008 19:56, Scott Wood wrote:
> > The memory-constrained platform I had in mind was 8xx, which doesn't use
> > bitbanged MDIO.  It might nice to keep the gpiolib bit separate to avoid
> > situations such as ep8248e where mdiobb would be the only thing requiring
> > a gpiolib binding, though -- but it shouldn't be two separate bitbang
> > drivers, just the existing bitbang driver plus some glue code that binds
> > it to gpiolib.
> 
> I would be fine with that if the glue code wasn't 90% of the whole driver. 
> There is really little (not to say nothing) that can be shared between the 
> two drivers.

I think we're thinking of a different pair of drivers...  I thought you
were talking about duplicating drivers/net/phy/mdio-bitbang.c, not
drivers/net/fs_enet/mii-bitbang.c.

-Scott
