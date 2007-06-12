Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070612044246.GC4198@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Tue, 12 Jun 2007 12:50:25 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So, what you're suggesting is a subnode for each described partition?

I'm saying this is a reasonable way to describe the regions
of flash the firmware itself cares about.

This isn't anything new; it is done like this on some
Apple systems, for example.

> Seems an awfully verbose way of going about it,

Not verbose, but flexible, and in line with everything
else about the device tree.

> and I don't see what
> it buys us over the partitions/partition-names pair of properties.

It is extensible.  It makes parsing trivial.  It
represents a flash partition in a way similar to how
a "whole" flash device is represented.


Segher
