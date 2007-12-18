Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 759EADDF7B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:17:21 +1100 (EST)
Message-ID: <4767F271.4090703@freescale.com>
Date: Tue, 18 Dec 2007 10:16:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071218035108.GA10212@localhost.localdomain>
In-Reply-To: <20071218035108.GA10212@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> In this case the driver and binding have been developed together and
> for the time being it does require PHY nodes, obviously.  I'm saying
> that maybe that requirement ought to be changed.

I don't see why.

> Well, phandle is only used to find the phy node itself, so it doesn't
> count.  The only piece of information there is the reg - the PHY id.
> Following a phandle to another node is a fairly complex way of finding
> a single integer.  
> 
> Eh, I guess it's ok, but just directly giving the PHY id or a probe
> mask in the MAC node would also be fine (we do this for 4xx EMAC).

It's not just a simple integer -- it also tells you which mdio bus it's on.

-Scott
