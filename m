Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 30887DE006
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 17:49:37 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Date: Fri, 23 Mar 2007 07:49:45 +0100
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<7ce9c69ae76258f47790c5ceb851a355@kernel.crashing.org>
	<20070323032440.GD28006@localhost.localdomain>
In-Reply-To: <20070323032440.GD28006@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703230749.45563.sr@denx.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 March 2007 04:24, David Gibson wrote:
> On Thu, Mar 22, 2007 at 12:02:56PM +0100, Segher Boessenkool wrote:
> > >>> However, #address-cells=2, #size-cells=1 is common enough that we
> > >>> really need to support that case.
> > >>
> > >> On the root node?!?  Who would do such a strange thing?
> > >
> > > Ebony, for one, it works nicely for a 32-bit system with >32-bit bus.
> >
> > It means you cannot have a 4GB-or-bigger region below your
> > root node.  Dunno if Ebony ever needs one, for I/O mapping
> > perhaps?
>
> Nope.  0-4GB is RAM, 4-8 is in-built IO, 8-12 is PCI IO, and I forget
> what 12-16 is, if anything.

The 440SPe supports up to 16GB of DDR2 (0-16GB). You might want to consider 
supporting this sort of setup here.

Best regards,
Stefan
