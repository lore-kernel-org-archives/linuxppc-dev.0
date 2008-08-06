Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B46E3DE227
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 03:35:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m76HZlCJ014125
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 10:35:48 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m76HZlpc029664
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 12:35:47 -0500 (CDT)
Date: Wed, 6 Aug 2008 12:35:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Message-ID: <20080806173547.GD3138@ld0162-tx32.am.freescale.net>
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
	<20080806134128.GA9533@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080806134128.GA9533@secretlab.ca>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 07:41:28AM -0600, Grant Likely wrote:
> On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
> > I'm trying to get the ppc6xx_defconfig booting on any 8641 (74xx/e600)  
> > system.  If I remove the 'simple-bus' compatible from the soc node in  
> > the .dts it works.  Otherwise it hangs at but and looks to be crashed in 
> > the serial driver due to accessing memory at 0.
> >
> > I've tried the same .dts (w/'simple-bus') using the  
> > mpc8641_hpcn_defconfig and things work.
> 
> The Xilinx folks hit something similar.  ns16550 nodes get matched if
> the parent claims simple-bus.  If extra stuff needs to be done to use
> that port, then bad things happen.

If extra stuff needs to be done, it shouldn't claim to be a simple-bus.

-Scott
