Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 16:34:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515063408.GE6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:28:09AM +0200, Segher Boessenkool wrote:
> > Anyone have any objection to the following:  each of these controllers
> > should have compatible properties listing 3 string, first, a specific
> > version for the CPU in question (e.g "ibm,sdram-440gp"), then a string
> > based on the type as listed below, finally "ibm,sdram-4xx".
> 
> Is that last entry ever useful?  Do all those controllers
> have something in common?

A quick glance over the descriptions in the 440GP and 405GP user
manuals suggests that they have most of the registers in common,
though I haven't checked to see if the semantics of those registers
are actually all the same.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
