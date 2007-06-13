Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Jun 2007 16:12:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070613061254.GG16148@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2007 at 12:50:25PM +0200, Segher Boessenkool wrote:
> > So, what you're suggesting is a subnode for each described partition?
> 
> I'm saying this is a reasonable way to describe the regions
> of flash the firmware itself cares about.
> 
> This isn't anything new; it is done like this on some
> Apple systems, for example.
> 
> > Seems an awfully verbose way of going about it,
> 
> Not verbose, but flexible, and in line with everything
> else about the device tree.
> 
> > and I don't see what
> > it buys us over the partitions/partition-names pair of properties.
> 
> It is extensible.  It makes parsing trivial.  It
> represents a flash partition in a way similar to how
> a "whole" flash device is represented.

Hrm, ok.  Between you and BenH you've convinced me.  I'll try to come
up with something.  I think we'll still need to support the old
properties as backwards compatibility thing.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
