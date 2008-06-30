Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B7B6DE267
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:55:56 +1000 (EST)
In-Reply-To: <20080630110410.7ee097ed.kim.phillips@freescale.com>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
	<2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
	<20080630110410.7ee097ed.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e590624fb4ff66d787a2fa3c44e00cbc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Date: Mon, 30 Jun 2008 18:55:34 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Also, these made-up names make you do more work: you'll need to
>
> who said they were made up?

I did.  These names do not refer to some physical part you can buy.

>> write up a binding for them, explaining exactly what a 1.0 device
>> etc. is (or at least point to documentation for it).  If you use
>> a name that refers to some device that people can easily google
>> for documentation, you can skip this (well, you might need to
>> write a binding anyway; but at least you won't have to explain
>> what the device _is_).
>
> documentation is available in the usual places, and it specifically
> points out which SEC version it references.

I can't find a manual online for "freescale sec"; googling
for "freescale sec-1.0" finds a manual for the PowerQUICC I;
is that the right one?  I don't know, so the binding needs
to explain it to me.

Going from SoC name -> SEC version is easy, but the other way around
not so.

Anyway, minor stuff.

> Plus, as I mentioned
> before, a lot of the differences between the SEC versions are miniscule
> feature bits scattered across the programming model.

I don't see how this is relevant, sorry.

>> Using actual model names also reduces the namespace pollution
>> (hopefully Freescale will not create some other MPC8272 device
>> ever, so "fsl,mpc8272-whatever" will never be a nice name to
>> use for any other device; OTOH, it's likely that Freescale will
>> create some other device called "SEC" (there are only so many
>> TLAs, after all), so "fsl,sec-n.m" isn't as future-proof.
>
> I doubt that; the SEC has been around for about a decade now and that
> hasn't happened.

You'll have to admit a three-letter acronym is a bigger namespace
squatter than a nice long name is.  But it's your namespace, I don't
care.

i tried googling for "freescale sec" to find any other devices called
SEC, but that didn't work out.  What is "insider trading"?  ;-)


Segher
