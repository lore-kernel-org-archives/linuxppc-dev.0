Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 16:18:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515061855.GD6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705150811.09927.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:11:09AM +0200, Stefan Roese wrote:
> On Tuesday 15 May 2007, David Gibson wrote:
> > > "ibm,sdram" is way too generic to ever be usefully
> > > used for device matching.
> >
> > Yeah, I guess this should be ibm,sdram-44x or ibm,sdram-4xx.  Better
> > go look up if any 40x chips use a similar sdram controller.
> 
> Here a list of the current 4xx SDRAM controllers:

Ah, thanks :).

Anyone have any objection to the following:  each of these controllers
should have compatible properties listing 3 string, first, a specific
version for the CPU in question (e.g "ibm,sdram-440gp"), then a string
based on the type as listed below, finally "ibm,sdram-4xx".

> SDRAM:		all 40x (except for 405EZ)
	ibm,sdram-40x

> DDR:		440GP, 440GX, 440EP, 440GR
	ibm,sdram-44x-ddr

> DDR2:		440SP, 440SPe
	ibm,sdram-44x-ddr2

> DDR2 (Denali):	440EPx, 440GRx
	ibm,sdram-44x-ddr2denali

Seem reasonable?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
