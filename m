Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Mar 2008 12:32:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Message-ID: <20080311013204.GJ11559@localhost.localdomain>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<9f7d0248e911f6fa1a2d4292c96ef72e@kernel.crashing.org>
	<20080310235429.GC11559@localhost.localdomain>
	<200803110143.50561.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200803110143.50561.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 01:43:49AM +0100, Arnd Bergmann wrote:
> On Tuesday 11 March 2008, David Gibson wrote:
> > On Fri, Mar 07, 2008 at 04:39:30AM +0100, Segher Boessenkool wrote:
> > > > This isn't a problem with this device tree, but it's probably time we
> > > > started establishing some conventional generic names for nand flash
> > > > and board-control devices.
> > > >
> > > > So, to start the ball rolling, I've seen several names for nand flash
> > > > nodes, I'd suggest we standardise on "nand-flash".
> > > 
> > > What's wrong with the already well-established generic name "flash"?
> > 
> > I was concerned that using "flash" for both NOR flash (which it
> > already is) and NAND flash might be unwise.  I am quite open to being
> > convinced otherwise, though.
> 
> One argument for just using "flash" is that there are much finer differences
> than just "NAND" and "NOR", with at least "dataflash", "OneNAND", "SD/MMC"
> being further types of flash that don't fit the categories exactly, though
> each one for different reasons.
> 
> For SD/MMC, there are good reasons to use something completely different,
> for the others, calling them all "flash" sounds better than fitting them
> into "nand" and "nor".

Ok, I'm convinced.  "flash" it is.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
