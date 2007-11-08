Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 9B302DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 04:04:23 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so305603wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Nov 2007 09:04:22 -0800 (PST)
Message-ID: <9e4733910711080904h7d0dfb90o61d15d0326aedbf9@mail.gmail.com>
Date: Thu, 8 Nov 2007 12:04:22 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <47333939.6050106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
	<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>
	<473258B8.4060905@genesi-usa.com>
	<9e4733910711071815x344319ebye89168320dd53c0@mail.gmail.com>
	<47333939.6050106@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
> Jon Smirl wrote:
> > On 11/7/07, Matt Sealey <matt@genesi-usa.com> wrote:
> >> Jon Smirl wrote:
> >>> I'm not in favor of all these fsl prefixes. These chip families
> >>> do get sold. What would we have done with intel,pxa320 all over
> >>> the place when they sold it to marvell? mass changes to
> >>> marvell,pxa320?
> >> That's the idea, and there'd be a compatible entry for
> >> intel,pxa320.
> >
> > The vendor part really isn't needed and it is going to be a source of
> >  trouble. The vendors are smart enough not to create two chips with
> > the same part number. Adding a vendor qualifier complicates things
> > needlessly.
>
> I think you may be placing too much faith in the vendors.
> Is a 7400 a Freescale powerpc chip, or a quad 2-input NAND gate? :-)

There has to be more to the part number for the Freescale powerpc chip
than just 7400.
7400 is a shorthand name, it is not an orderable part number.

> If you want to argue that the "MPC" part differentiates them, that's
> just a less readable and more obsolete vendor prefix.

The MPC is what is printed on the chip. fsl is not printed there. MPC
is part of the orderable part number.


>
> And not all compatible entries are part numbers; many are descriptions
> of programming interfaces (such as cpm2 or gianfar).  I'm not inclined
> to bet that there will never be a conflict in such a namespace.
>
> >> Actually the spec says you should use the stock ticker (IBM, FSL,
> >> INTC, JAVA, MRVL) if they have one and if not, the company name in
> >> lower case.
> >>
> >> Freescale are a funny one because they used to have a stock ticker
> >> as MOT and then FSL but now they're privately owned, so it's gonna
> >> have to be lower case :]
>
> Well, technically the recommended prefix is an OUI number, and those are
> less likely to change due to corporate shuffling, but they suck from a
> readability perspective.
>
> > Another example of how these vendor prefixes can change. The chip
> > numbers are never going to change. Just use them and drop these
> > vendor prefixes.
>
> No. :-)
>
> >> functionality. fsl,has-wdt differs from has-wdt ideally because
> >
> > This one I can buy, but it should be fsl-has-wdt. Drop the vendor
> > prefixes.
>
> How is fsl-has-wdt any better, other than it obscures namespace issues?
>
> Vendor prefixes on properties are useful in that it might not mean
> exactly the same thing as a similar property that gets standardized
> later on.
>
> > That's life in the Linux world, no backwards binary compatibility.
>
> There's a huge difference between compatibility of kernel interfaces and
> compatibility of interfaces between the kernel and something else --
> whether it be userspace or firmware.
>
> -Scott
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
