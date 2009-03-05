Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6FC57DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 07:06:15 +1100 (EST)
Date: Thu, 5 Mar 2009 14:08:29 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only build Axon MSI driver for IBM Cell
	Blades
Message-ID: <20090305200829.GA22801@lixom.net>
References: <e9c405aaec255c2a3d34209fc35ae093fcae8efc.1236228043.git.michael@ellerman.id.au>
	<20090305071356.GA9412@lixom.net>
	<1236262025.8325.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236262025.8325.12.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 06, 2009 at 01:07:05AM +1100, Michael Ellerman wrote:
> On Thu, 2009-03-05 at 01:13 -0600, Olof Johansson wrote:
> > On Thu, Mar 05, 2009 at 03:41:41PM +1100, Michael Ellerman wrote:
> > > The hardware is only present on those machines, and the driver
> > > depends on infrastructure which is selected by the Kconfig for
> > > cell blades.
> > 
> > Wouldn't it make more sense to make a separate (AXON_MSI) config option
> > depend on PPC_IBM_CELL_BLADE?
> 
> Maybe, it would make the makefile cleaner, at the expense of a bit more
> Kconfig. I'm not sure what people prefer, I guess I'm neutral and you're
> voting for the latter, so I'll respin it that way :)

Yeah, I'm not really that picky either, it just set off a red flag
w.r.t. setting a bad precedence on ifdef:ing in the makefile instead of
Kconfig engineering. Slippery slope and all that.


-Olof
