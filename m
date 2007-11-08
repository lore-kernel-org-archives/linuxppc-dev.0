Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10352DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 19:42:35 +1100 (EST)
Subject: Re: [PATCH 2/6] ibm_newemac: Add ET1011c PHY support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711080941.46894.sr@denx.de>
References: <20071108080729.E09F7DDDFB@ozlabs.org>
	<200711080941.46894.sr@denx.de>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 19:42:24 +1100
Message-Id: <1194511344.6561.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +static struct mii_phy_def et1011c_phy_def = {
> > +        .phy_id         = 0x0282f000,
> > +        .phy_id_mask    = 0x0fffff00,
> > +        .name           = "ET1011C Gigabit Ethernet",
> > +        .ops            = &et1011c_phy_ops
> > +};
> > +
> > +
> > +
> > +
> > +
> 
> Nitpicking: Too many empty lines for my taste.

Agreed, I though I had removed them, looks like I didn't. Will fix that
before submitting.

Thanks,
Ben.
