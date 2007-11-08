Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A783DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 07:56:29 +1100 (EST)
Message-ID: <473377F8.2050802@freescale.com>
Date: Thu, 08 Nov 2007 14:56:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	
	<4732396D.4040904@genesi-usa.com>	
	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>	
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>	
	<473375E6.5080503@freescale.com>
	<9e4733910711081251w392b4a84m8e81d902305bf395@mail.gmail.com>
In-Reply-To: <9e4733910711081251w392b4a84m8e81d902305bf395@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jon Smirl wrote:
> On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
>> Jon Smirl wrote:
>>> No one has answered this yet. It makes no sense at all to mix use of
>>> the vendor prefix on some compatible entries and not on others. The
>>> syntax of compatible entries needs to be consistent.
>> Right, the vendor prefix should always be used.  Not all of the existing
>> trees are perfect, however, so sometimes the code needs to stay
>> compatible, especially when the device tree is difficult to change.
> 
> A bunch of patches are going to have to go into the kernel. Code
> expecting tree attributes without vendor prefixes is all over the
> kernel.

It's just nonstandard properties that need it, not all of them.

> All of the dts file need to be patched up, etc.

I don't think *all* the dts files have problems...

> As far as I know the only dts using vendor prefixes in the compatible
> attributes is 5200lite one for the gpt entries. Everything else will
> need to be changed.

Look a little harder.  Many of the Freescale boards/devices do it right 
-- and yes, we need to fix the ones that don't.

-Scott
