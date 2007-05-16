Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 May 2007 13:47:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070516034738.GE19127@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
	<20070515063408.GE6998@localhost.localdomain>
	<5c785f662c13fdd938d48e40d3107050@kernel.crashing.org>
	<20070515065826.GF6998@localhost.localdomain>
	<e909c6361f679071300958431723d8be@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e909c6361f679071300958431723d8be@kernel.crashing.org>
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

On Tue, May 15, 2007 at 09:07:52AM +0200, Segher Boessenkool wrote:
> > Sod it, I think I'll just drop everything except "ibm,sdram-440gp" for
> > now.
> 
> Perfect plan :-)  And then 440GX, GR, etc. can claim
> compatibility to 440GP, which is the nestor of the
> family.

Right, done.  Same for the SRAM and DMA controller nodes.

New patch coming shortly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
