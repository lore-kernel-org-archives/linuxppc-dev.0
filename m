Return-Path: <jacmet@sunsite.dk>
Received: from asia.telenet-ops.be (asia.telenet-ops.be [195.130.137.74])
	by ozlabs.org (Postfix) with ESMTP id 7B94B689C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 07:30:31 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<200601251702.20332.laurent.pinchart@tbox.biz>
	<20060130172851.GF22672@smtp.west.cox.net>
	<200601310947.32463.laurent.pinchart@tbox.biz>
	<20060131142433.GN22672@smtp.west.cox.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 31 Jan 2006 21:31:56 +0100
In-Reply-To: <20060131142433.GN22672@smtp.west.cox.net> (Tom Rini's message
	of "Tue, 31 Jan 2006 07:24:34 -0700")
Message-ID: <87slr4b0lf.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

 Tom> I would suggest either Linus' current git tree or 2.6.16-rc1 if
 Tom> you don't use git.  But please bear in mind that since this is a
 Tom> new feature (a new board) it won't be submitted to Linus' tree
 Tom> until 2.6.17-rc1 opens up (and if in that time, it becomes much
 Tom> easier to put this board under arch/powerpc it should be done
 Tom> under there, instead).

I only recently moved from 2.4 to 2.6, so this may be a FAQ, but a
quick googling around didn't find anything.

What is this arch/ppc -> arch/powerpc about? Some kind of
consolidation of ppc and ppc64? What's the reason behind it and what
kind of time frame are we talking about? Is it related to the bd_t ->
flattened OF tree change?

Could someone post a few pointers to more information? 

-- 
Bye, Peter Korsgaard
