Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070613091904.GA30948@localhost.localdomain>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
	<20070613061254.GG16148@localhost.localdomain>
	<bc98b5372977d171b0075074bfce7747@kernel.crashing.org>
	<20070613091904.GA30948@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <791ab8b82c5b5d2b3ae4827a891a43ea@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Wed, 13 Jun 2007 11:37:42 +0200
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

>> How do non-device-tree MTD users handle this?
>
> Invidual, board-specific map files with hardcoded partition tables.

That's what I was afraid of.  Sigh.

> See drivers/mtd/maps/ebony.c for example.

[/me looks...]  Oh horror.

> Hence my view of the device
> tree as a preferable option.

I think some binary partition table format that can be
used by _all_ MTD consumers should be defined.  How
that table should be communicated to the kernel in the
device tree case we can discuss later, then.  Maybe
something as simple as storing it in flash, and have a
"partition-table-offset" property or something like that.

This is something the MTD people will have to buy into
of course.


Segher
