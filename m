Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A232DDF1A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 19:35:59 +1000 (EST)
Subject: Re: [PATCH 3/3] ibm_newemac: MAL support for PowerPC 405EZ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080904234145.17f55cc2@zod.rchland.ibm.com>
References: <cover.1220540078.git.jwboyer@linux.vnet.ibm.com>
	<20080904150216.GD2479@yoda.jdub.homelinux.org>
	<20080905021037.GG14128@verge.net.au>
	<20080904234145.17f55cc2@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 19:34:38 +1000
Message-Id: <1220607278.4879.165.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > +	if (of_device_is_compatible(ofdev->node, "ibm,mcmal-405ez"))
> > > +		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT | MAL_FTR_COMMON_ERR_INT);
> > 
> > The above like is >80 characters wide.
> > But I'm not sure that anyone cares.
> 
> I don't.  If Ben complains I'll change it.

I wouldn't do a tatrum over it but if you're going to respin the
patch you may as well put the second constant on the next line.

Cheers,
Ben.
