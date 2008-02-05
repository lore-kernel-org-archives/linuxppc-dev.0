Return-Path: <dgibson@ozlabs.org>
Date: Tue, 5 Feb 2008 13:40:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/10] sbc8560: Add v1 device tree source for Wind River
	SBC8560 board
Message-ID: <20080205024049.GC28846@localhost.localdomain>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
	<7107e511a0f989ad55335855fa0f241f09eff52f.1201217172.git.paul.gortmaker@windriver.com>
	<20080201075408.GC18684@localhost.localdomain>
	<FF018A8D-21AC-4F05-887B-66B99A0D444C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF018A8D-21AC-4F05-887B-66B99A0D444C@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 08:46:32AM -0600, Kumar Gala wrote:
> 
> On Feb 1, 2008, at 1:54 AM, David Gibson wrote:
> 
> > On Thu, Jan 24, 2008 at 06:41:24PM -0500, Paul Gortmaker wrote:
[snip]
> >> +		epld@5,0 {
> >
> > I'm not entirely convinced on this two-level representation.  I think
> > the FSL people need to get together and define a binding (or set of
> > bindings) for their various chipselect style external bus bridges.
> 
> It seems reasonable if you had a FPGA off of the localbus to have a  
> two level representation.  One for the localbus controller on the FSL  
> part and the child to describe the FPGA.
> 
> What are you expecting beyond what we have today?  I guess I'm asking  
> what's missing from the localbus nodes we have?

Sorry, I was probably misleading.  All I really meant is that I don't
know enough about these FSL bus bridge arrangements to assess if this
representation is the most sensible one.  I'm presuming that this
chipselect bridge unit is a more-or-less standard ASIC appearing on
lots of the FSL chips, so it would be nice to have a standard binding
for them, as we do for the roughly-equivalent EBC bridge on 4xx.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
