Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9603EDE302
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:04:19 +1000 (EST)
Date: Mon, 30 Jun 2008 11:04:10 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Message-Id: <20080630110410.7ee097ed.kim.phillips@freescale.com>
In-Reply-To: <2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
	<2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 29 Jun 2008 01:37:12 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > I'm really don't like "fsl,sec1.0" or any of the variants as a
> > compatible property either because it can easily be abused (it's not
> > anchored to a specific physical part so the meaning can shift over
> > time); but that is another argument and it is well documented in other
> > email threads  
> > (http://thread.gmane.org/gmane.linux.ports.ppc64.devel/38977/ 
> > focus=39147)
> 
> Also, these made-up names make you do more work: you'll need to

who said they were made up?

> write up a binding for them, explaining exactly what a 1.0 device
> etc. is (or at least point to documentation for it).  If you use
> a name that refers to some device that people can easily google
> for documentation, you can skip this (well, you might need to
> write a binding anyway; but at least you won't have to explain
> what the device _is_).

documentation is available in the usual places, and it specifically
points out which SEC version it references.  Plus, as I mentioned
before, a lot of the differences between the SEC versions are miniscule
feature bits scattered across the programming model. 

> Using actual model names also reduces the namespace pollution
> (hopefully Freescale will not create some other MPC8272 device
> ever, so "fsl,mpc8272-whatever" will never be a nice name to
> use for any other device; OTOH, it's likely that Freescale will
> create some other device called "SEC" (there are only so many
> TLAs, after all), so "fsl,sec-n.m" isn't as future-proof.

I doubt that; the SEC has been around for about a decade now and that
hasn't happened.  The SEC is on par with the TSEC ethernet controller
as far as this goes.

Kim
