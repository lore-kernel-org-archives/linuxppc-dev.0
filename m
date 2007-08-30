Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B054CDDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 15:49:04 +1000 (EST)
Date: Thu, 30 Aug 2007 00:48:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] Introduce new CPM device bindings.
Message-ID: <20070830054854.GA21533@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201619.GB24210@ld0162-tx32.am.freescale.net>
	<20070829053941.GC3206@localhost.localdomain>
	<20070829135806.GB30184@ld0162-tx32.am.freescale.net>
	<20070830005559.GB22844@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830005559.GB22844@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 10:55:59AM +1000, David Gibson wrote:
> Am I correct in thinking that it's basically an arch/ppc versus
> arch/powerpc thing.  In which case couldn't you use CONFIG_PPC_MERGE
> instead?

The idea was to allow boards to be converted incrementally, as I don't
have access to test 100% of the boards that use the CPM code.

> > It has a phandle to the phy node...  if you mean the mdio bus node, why?
> 
> Well, I'm just working of the example of 4xx EMAC.  The way it does
> mdio, it wants a handle on the mdio bus to perform various operations
> there as well on the phy to tell it how to address them.  fsl-enet may
> do things differently and have no particular need for such a handle.

Even if it did need such a handle, couldn't it just look at the phy
node's parent?

-Scott
