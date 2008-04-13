Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56E3ADE1DB
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 13:13:26 +1000 (EST)
To: seanm@seanm.ca
In-Reply-To: <20080412223833.27ca5f23@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
	<20080412215544.38fa2d0b@lappy.seanm.ca>
	<fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
Message-Id: <E1Jksea-0001ba-DL@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Sat, 12 Apr 2008 20:13:16 -0700
Subject: Re: Warp patches for 2.6.26
Cc: , linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In article <20080412223833.27ca5f23@lappy.seanm.ca> you write:
>  
> > A changelog of "updates a bunch of stuff" is pretty much irrelevant in
> > all situations I can think of.
> 
> Ok, I hope I got everything:
> 
> Changes to match new FPGA/HW functionality.
> * Switched from 64M NOR/64M NAND to 4M NOR/256M NAND.
> * Moved/resized partitions to match the flash changes.
> * Fixup code added for Rev A boards to handle flash changes.
> * Added DTM critical temperature.
> * Added DTM fan error - currently disable in FPGA.
> * Added POST information.
> * Removed LED function, moved to new LED driver.
> * Moved ad7414 to new style I2C initialization.

Each patch needs to be standalone.  you need to add a header describing
what the patch is intended to accomplish.  Being more descriptive is
better than less.  Also, as Stephen said, make sure that the subject
of each email containing a patch is descriptive and reasonably unique
within the entire kernel.  For example, instead of "WDT driver", as a
minimum something like: "[POWERPC] warp: Add WDT driver".

-Dale
