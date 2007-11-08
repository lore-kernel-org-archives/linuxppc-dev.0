Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 725FBDDE21
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 07:00:46 +1100 (EST)
Message-ID: <47336A38.1020807@freescale.com>
Date: Thu, 08 Nov 2007 13:57:44 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>		<4732396D.4040904@genesi-usa.com>		<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>		<473258B8.4060905@genesi-usa.com>		<9e4733910711071815x344319ebye89168320dd53c0@mail.gmail.com>		<47333939.6050106@freescale.com>	<9e4733910711080904h7d0dfb90o61d15d0326aedbf9@mail.gmail.com>
	<47336805.4040807@genesi-usa.com>
In-Reply-To: <47336805.4040807@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Matt Sealey wrote:

> The orderable part numbers add 3 or 4 characters to the front and about
> 8 after. There is a difference between MPC7400 and PPC7400, and the
> low voltage versions, and the different clock speeds. Orderable part
> number for a recent G4 might be PPC7448B1333NL -

Yeah, part, stepping, variant, speed, etc.

> this is a ridiculous
> amount of specificity in a device tree, 

Except that some of that information _is_ specified
elsewhere in other properties.  Speed, for example.

> and it also does not match the
> datasheet (MPC7448 is the name of the chip).

Because the data sheets are _soooo_ reliable. :-)



> Indeed, so.. at some point we should all sit down and hammer out the
> major issues in describing something like the MPC5121E because right
> now Genesi has a vested interest in that.

You understand that _that_ is being worked on as we, er, speak?


> If we could all agree on how it should be mapped out, with an example
> tree which shows *every damn thing available* so platform developers
> can pick and choose and OF developers can use it as a reference, it
> would make a much happier process.

Right.  It's being nailed down, but it is a slow, community process...

> And then we can fix up the Efika to fit some definition of the new
> MPC5200 tree too.

*gasp*

> By the way while I was poking around the tree today I noticed that
> there is a PCI errata fixup handled by a Kconfig in there. Why?

Happens occasionally.  And other places as well.

> Surely
> this is something you check the PVR/SVR for and switch on that for
> a runtime solution, 

That's not always fine-grained enough to base a decision on it.

> and not trick users with the possibility of
> forgetting to enable some obscure "PCI errata fix" configuration
> item? (CONFIG_PPC_MPC5200_BUGFIX)

It should be in the defconfig. :-)

jdl
