Return-Path: <Marta.Chamorro@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "wvmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C113567C7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 02:18:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Power management for ppc 85xx
Date: Tue, 12 Dec 2006 15:17:55 -0000
Message-ID: <BFEE19E1D0DBF84698D76276388DCB84435E82@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <457A4A40.2060803@anagramm.de>
From: "Chamorro, Marta" <Marta.Chamorro@xerox.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
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


Hi Clemens,

>=20
> Hello, Kumar, Hi, Marta!
>=20
> >> Glad I managed to make sense. I checked the hardware spec on the
board
> >> and it looks like we're using everything, apart from the SEC and
maybe
> >> the stand-alone I2C (I think we're just using the one within the
CMP).
> >> By the way, I made a mistake and the actual processor on the board
is
> >> the cut-down 8541, not the 8555. My apologies for that.
> >>
> >> This morning I added some printks and confirmed that there is no
code
> >> behind pm_ops, so my question remains: is there some code out there
> >> that
> >> I can use? (hope so, otherwise I'm doomed...)
> >
> > I'm sorry to say you're doomed.  I don't believe anyone's spent any
> > time trying to do pwr mgmt on 85xx.
>=20
> I am working with the MPC8540 in a mobile product and some
> power saving would be fine to use. But I haven't seen any
> power management code for that thingy in the kernels at all.
> So, there is some work left there. Maybe I will have
> a closer look in the future.
>=20
> According to some tests of a board manufacturer, the cpu
> doesn't power down very much, when you stop some peripherals
> or send the core to nap. But I wasn't able to confirm that yet.

We're estimating 2.5 watts saving on doze mode, in case that helps.
That's for a 8545 @ 800MHz

>=20
> Best greets,
>=20
> Clemens Koller
> _______________________________

Bfn,

Marta Chamorro
