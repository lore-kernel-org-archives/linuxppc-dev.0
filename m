Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai01.cox.net (fed1rmmtai01.cox.net [68.230.241.58])
	by ozlabs.org (Postfix) with ESMTP id 140F02BDB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 08:21:04 +1000 (EST)
Date: Fri, 1 Oct 2004 15:06:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20041001220648.GJ21896@smtp.west.cox.net>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2004 at 10:11:03PM -0500, Kumar Gala wrote:
> >> But on the other hand, I've given up a long time ago trying to 
> >enforce any
> > > kind of sane model on ppc32 because the embedded folks only care 
> >about having
> > > a quick ugly broken hack to work with their board, thus the 
> >explosion of
> > > various incompatible boot_info structures that we have nowadays.
> >
> >Yes indeed. It's ugly and needs fixing so I'll take a look at it - I
> > just don't want to do this if everyone here already knows of a better
> > solution which will work.
> >
> >Then Xilinx et al can generate memory maps and we can head towards
> > having a single kernel binary bootable on multiple different ppc
> > boards.
> 
> I would be nice to have an extensive and dynamic way to pass info from 
> the bootloader to the kernel.  I believe that Wolfgang has stated he 
> would be willing to change u-boot to match.  I'd be willing to fixup 
> and move Freescale boards over to use something as long as we get 
> u-boot to support it as well.
> 
> I've been told that ARM has a solution, in place, to this problem that 
> might always be worth looking at.

I know the ARM folks on the list will yell at me, but to be a bit too
simple, it's a linked list of BI_ bits.

I've been thinking about it, and I do believe that Ben's flattened OF
tree wins the "show me the code" race, so lets go that way.  I'll add in
that for most platforms we'll want to build up the tree at compile time,
but U-Boot, and anything else smart enough can pass one in for real.

Jon, I look forward to your patch. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
