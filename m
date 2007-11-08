Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73280DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 23:12:42 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8CECjm022834
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 07:14:12 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8CCZm8111230
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 07:12:35 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8CCZ9r029862
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 07:12:35 -0500
Date: Thu, 8 Nov 2007 06:08:05 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/6] ibm_newemac: Add ET1011c PHY support
Message-ID: <20071108060805.4c59b579@zod.rchland.ibm.com>
In-Reply-To: <1194511344.6561.0.camel@pasglop>
References: <20071108080729.E09F7DDDFB@ozlabs.org>
	<200711080941.46894.sr@denx.de> <1194511344.6561.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 08 Nov 2007 19:42:24 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > +static struct mii_phy_def et1011c_phy_def = {
> > > +        .phy_id         = 0x0282f000,
> > > +        .phy_id_mask    = 0x0fffff00,
> > > +        .name           = "ET1011C Gigabit Ethernet",
> > > +        .ops            = &et1011c_phy_ops
> > > +};
> > > +
> > > +
> > > +
> > > +
> > > +
> > 
> > Nitpicking: Too many empty lines for my taste.
> 
> Agreed, I though I had removed them, looks like I didn't. Will fix that
> before submitting.

DENX is pretty good about having Signed-off-by lines in their tree...
maybe you should add the original authors as well if it's there.

josh
