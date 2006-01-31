Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 67A4C68A1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 07:40:30 +1100 (EST)
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
From: Jon Loeliger <jdl@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87slr4b0lf.fsf@48ers.dk>
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<200601251702.20332.laurent.pinchart@tbox.biz>
	<20060130172851.GF22672@smtp.west.cox.net>
	<200601310947.32463.laurent.pinchart@tbox.biz>
	<20060131142433.GN22672@smtp.west.cox.net>  <87slr4b0lf.fsf@48ers.dk>
Content-Type: text/plain
Message-Id: <1138740025.24410.57.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 31 Jan 2006 14:40:26 -0600
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-01-31 at 14:31, Peter Korsgaard wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
>  Tom> I would suggest either Linus' current git tree or 2.6.16-rc1 if
>  Tom> you don't use git.  But please bear in mind that since this is a
>  Tom> new feature (a new board) it won't be submitted to Linus' tree
>  Tom> until 2.6.17-rc1 opens up (and if in that time, it becomes much
>  Tom> easier to put this board under arch/powerpc it should be done
>  Tom> under there, instead).
> 
> I only recently moved from 2.4 to 2.6, so this may be a FAQ, but a
> quick googling around didn't find anything.
> 
> What is this arch/ppc -> arch/powerpc about? Some kind of
> consolidation of ppc and ppc64?

Exactly.

> What's the reason behind it

Eliminate duplicate code.  Share good code.
Improved modularity.  Leverage.  All the Good Stuff (tm).
Eliminate the bd_t mess.  You know.

> and what kind of time frame are we talking about?

In progress now.  All of the PPC64 ports are now officially
part of the "powerpc" arch.  There are two published PPC32
ports (MPC8349SYS and MPC8540ADS) that have been posted to
the list as being "merged" into the powerpc arch.  They are
still evolving a bit, though.

>  Is it related to the bd_t ->
> flattened OF tree change?

Yes.  New World Order says all arch/powerpc ports will 
use a common flat dev tree interface from boot loaders
unless honest OF is available.  The bd_t is obsolete.

> Could someone post a few pointers to more information? 

Read the "booting without open firmware" spec recently
patched from the DTC code tree to the linux doc directory
on the PPC64 list by Dave Gibson.

Read the Device Tree Compiler code itself too.

jdl
