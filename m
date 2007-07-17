Return-Path: <dgibson@ozlabs.org>
Date: Tue, 17 Jul 2007 12:42:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Message-ID: <20070717024246.GA6482@localhost.localdomain>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
	<8CA741AA-D200-474F-943D-ECE4B3ACD38B@kernel.crashing.org>
	<18068.5706.700933.551828@cargo.ozlabs.ibm.com>
	<89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 02:03:24AM +0200, Segher Boessenkool wrote:
> >> Yeah.  Giving the warning is a good thing though.
> >
> > No, it isn't; it's just noise, if we're not ever going to do anything
> > to prevent the behaviour - and we can't.
> 
> The same userland code will not run correctly on PPC64 or BookE
> systems.  Is that not a reason to warn?

Way back when, I distinctly recall aborting my plans to implement
per-page exec on 40x, precisely because of executables like this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
