Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Jun 2007 14:12:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070615041233.GA30104@localhost.localdomain>
References: <548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
	<1181228442.2785.60.camel@pmac.infradead.org>
	<18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
	<20070612044459.GD4198@localhost.localdomain>
	<9e1a55ac71a2ecf5155d2fddf547025e@kernel.crashing.org>
	<20070613031615.GC16148@localhost.localdomain>
	<96f5b23c4f53e986e8caa2156f149cd8@kernel.crashing.org>
	<20070613061152.GF16148@localhost.localdomain>
	<40446e5131495e077da798bc54843b2a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40446e5131495e077da798bc54843b2a@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2007 at 11:10:42AM +0200, Segher Boessenkool wrote:
> >> MTD does a lot of heuristic probing.  It is pretty good,
> >> but it would be nice if you could skip that and hand it
> >> the exact values it needs.  Also, this information should
> >> be in the device tree no matter what, even if Linux
> >> doesn't use it yet ;-)
> >
> > I agree.  Of course, this means figuring out what the values actually
> > are for Ebony.  I presently have no idea, since the heuristic probing
> > appears to work without problem.
> 
> Doesn't it show it in sysfs, or in the dmesg at least?
> Maybe some other important stuff is there, too.

Not as far as I can tell.  Only dmesg information I can see is:

1ff800000.large-fla: Found 1 x8 devices at 0x0 in 8-bit bank
1ff800000.large-fla: Found 1 x8 devices at 0x200000 in 8-bit bank
number of JEDEC chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code
brokenness.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
