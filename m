Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Jun 2007 19:19:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070613091904.GA30948@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
	<20070613061254.GG16148@localhost.localdomain>
	<bc98b5372977d171b0075074bfce7747@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc98b5372977d171b0075074bfce7747@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2007 at 11:13:21AM +0200, Segher Boessenkool wrote:
> > Hrm, ok.  Between you and BenH you've convinced me.  I'll try to come
> > up with something.  I think we'll still need to support the old
> > properties as backwards compatibility thing.
> 
> Yes, of course.
> 
> I'm still not happy with creating nodes for application
> flash partitions in the device tree; this isn't done
> for disk partitions either, for analogue reasons (namely,
> that info doesn't belong in the device tree, it is the
> wrong abstraction).
> 
> How do non-device-tree MTD users handle this?

Invidual, board-specific map files with hardcoded partition tables.
See drivers/mtd/maps/ebony.c for example.  Hence my view of the device
tree as a preferable option.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
