Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id AEAC92BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 01:02:44 +1000 (EST)
In-Reply-To: <20041004074105.A11487@home.com>
References: <20041004074105.A11487@home.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <20608413-1616-11D9-9774-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 4 Oct 2004 10:00:27 -0500
To: "Matt Porter" <mporter@kernel.crashing.org>
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


On Oct 4, 2004, at 9:41 AM, Matt Porter wrote:

> On Mon, Oct 04, 2004 at 07:29:09AM -0700, Tom Rini wrote:
>  > On Mon, Oct 04, 2004 at 09:07:20AM +0300, Pantelis Antoniou wrote:
>  > > Tom Rini wrote:
>  > [snip]
>  > > >I've been thinking about it, and I do believe that Ben's=20
> flattened OF
>  > > >tree wins the "show me the code" race, so lets go that way.=A0=20=

> I'll add in
>  > > >that for most platforms we'll want to build up the tree at=20
> compile time,
>  > > >but U-Boot, and anything else smart enough can pass one in for=20=

> real.
>  > > >
>  > > >Jon, I look forward to your patch. :)
>  > > >
>  > > >
>  > > Allow me, to cut in and plug my own thing.
>  > [snip]
>  > > I just create an argv of all the environment variables of the=20
> firmware
>  > > and I pass the psysical address of that NULL terminated argv =
array
>  > > to the kernel command line like so... "u-boot-env=3D0x0f000f00".
> >
> > The 'problem' I forsee with this is that we still have two methods=20=

> for
>  > getting stuff in, an OF tree or env array.=A0 If we got with a fake =
OF
>  > tree, we have just one method and we can always use it.
>  >
> > [snip]
>  > > I know this is the Nth time this discussion is taking place bu=20
> IMO something
>  > > must be finally decided. I don't really care if my solution will=20=

> be selected
>  > > as long as something is at last selected.
>  >
> > As far as I'm concerned, unless some horrible problem springs up =
that
> > we can't resolve, this is it.
>
> Same here, I see that no one has raised a technical issue with the
>  flattened device tree method. Since it is a working mechanism AND it
>  unifies the arch, it's the clear choice over reinventing the wheel.
>  All we need is an implementation.

I'm in agreement with Matt and Tom.  We should only have one solution=20
to this problem.

- kumar
