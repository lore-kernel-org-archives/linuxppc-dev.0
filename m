Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id BF27E2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 00:41:10 +1000 (EST)
Date: Mon, 4 Oct 2004 07:41:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20041004074105.A11487@home.com>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<20041001220648.GJ21896@smtp.west.cox.net>
	<4160E898.9080905@intracom.gr>
	<20041004142909.GA27376@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041004142909.GA27376@smtp.west.cox.net>;
	from trini@kernel.crashing.org on Mon, Oct 04, 2004 at 07:29:09AM
	-0700
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

On Mon, Oct 04, 2004 at 07:29:09AM -0700, Tom Rini wrote:
> On Mon, Oct 04, 2004 at 09:07:20AM +0300, Pantelis Antoniou wrote:
> > Tom Rini wrote:
> [snip]
> > >I've been thinking about it, and I do believe that Ben's flattened OF
> > >tree wins the "show me the code" race, so lets go that way.  I'll add in
> > >that for most platforms we'll want to build up the tree at compile time,
> > >but U-Boot, and anything else smart enough can pass one in for real.
> > >
> > >Jon, I look forward to your patch. :)
> > >
> > >
> > Allow me, to cut in and plug my own thing.
> [snip]
> > I just create an argv of all the environment variables of the firmware
> > and I pass the psysical address of that NULL terminated argv array
> > to the kernel command line like so... "u-boot-env=0x0f000f00".
> 
> The 'problem' I forsee with this is that we still have two methods for
> getting stuff in, an OF tree or env array.  If we got with a fake OF
> tree, we have just one method and we can always use it.
> 
> [snip]
> > I know this is the Nth time this discussion is taking place bu IMO something
> > must be finally decided. I don't really care if my solution will be selected
> > as long as something is at last selected.
> 
> As far as I'm concerned, unless some horrible problem springs up that
> we can't resolve, this is it.

Same here, I see that no one has raised a technical issue with the
flattened device tree method. Since it is a working mechanism AND it
unifies the arch, it's the clear choice over reinventing the wheel.
All we need is an implementation.

-Matt
