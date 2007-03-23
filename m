Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:17:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070323231716.GA4459@localhost.localdomain>
References: <45FEA7B3.9090304@freescale.com>
	<20070320035957.GC21124@localhost.localdomain>
	<45FFE8FD.9020902@freescale.com>
	<20070321025447.GG27969@localhost.localdomain>
	<460148DC.3020600@freescale.com>
	<20070322000620.GC2295@localhost.localdomain>
	<1174576516.6595.542.camel@ld0161-tx32>
	<20070323032214.GC28006@localhost.localdomain>
	<4603E648.4030907@freescale.com>
	<fe12f78e018a5543b0e8f7fc636dc5c3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe12f78e018a5543b0e8f7fc636dc5c3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 05:37:47PM +0100, Segher Boessenkool wrote:
> >> Well, that's part of why I'm contemplating this idea:  it makes it
> >> clear to the reader whether this dts is intended to be complete, or
> >> whether it's intended that the bootloader adjust things.
> >
> > I would have no objection to a patch for DTC that makes it treat "?"
> > like "0".  This would probably make everyone happy.
> 
> Some nice poison pattern instead of 0 would be even
> better.

I was thinking of having the poison configurable on the command line,
though it would probably default to 0.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
