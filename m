Return-Path: <jdl@jdl.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 00/11] dtc: some fixes, and make asm labels for data 
In-Reply-To: Your message of "Sat, 07 Jul 2007 01:18:45 CDT."
	<dtc-5-00.miltonm@bga.com>
References: <dtc-5-00.miltonm@bga.com> 
Date: Sat, 07 Jul 2007 14:24:06 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I7Ft0-0004Eq-5e@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Milton Miller mumbled:
> The following series adds the features of labeling memory reserve
> slots and labeling specific bytes or cells of property data.  When
> translating from dts to asm, a global symbol is created with the
> name matching the label in the dts file.

Milton,

I applied the whole lot.
Minor English typo corrections in commit log messages.

Also, I added two patches on top of these to reorganize
the Makefile into a better top-down layout and added
some Version string support, borrowed almost verbatim
from the Linux Makefiles.  We're going to arbitrarily
start with 1.0.0 unless someone has a good argument for
something else!

And, for those keeping track, my "To Do" list here still
contains the notion of breaking the booting-without-of.txt
file into two parts.  The technical descriptions of the DTC
and its file (blob) layout will move to the DTC repository
while the descriptions of nodes and properties will remain
in the kernel repository.

Let me know what you think...

Thanks,
jdl
