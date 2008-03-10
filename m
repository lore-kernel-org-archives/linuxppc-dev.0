Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Mar 2008 10:54:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Message-ID: <20080310235429.GC11559@localhost.localdomain>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<20080307002730.GB24142@localhost.localdomain>
	<9f7d0248e911f6fa1a2d4292c96ef72e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f7d0248e911f6fa1a2d4292c96ef72e@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 04:39:30AM +0100, Segher Boessenkool wrote:
> > This isn't a problem with this device tree, but it's probably time we
> > started establishing some conventional generic names for nand flash
> > and board-control devices.
> >
> > So, to start the ball rolling, I've seen several names for nand flash
> > nodes, I'd suggest we standardise on "nand-flash".
> 
> What's wrong with the already well-established generic name "flash"?

I was concerned that using "flash" for both NOR flash (which it
already is) and NAND flash might be unwise.  I am quite open to being
convinced otherwise, though.

> > I've seen several variants for board control devices (cpld, bcsr,
> > fpga, etc.) I suggest we standardise on "board-control"
> 
> Fine with me, but it's very vague (hard to avoid though).

Yes.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
