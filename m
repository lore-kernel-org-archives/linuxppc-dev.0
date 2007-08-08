Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AAB8DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 08:17:08 +1000 (EST)
In-Reply-To: <1186300813.5534.33.camel@localhost>
References: <1185047879.15040.34.camel@localhost>
	<fa686aa40707211317q47b12a38jbe05e4d2c89767f4@mail.gmail.com>
	<1186300813.5534.33.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <A8A2F848-D3C0-4DDA-BFF4-F4E8CB06DC12@freescale.com>
From: Timur Tabi <timur@freescale.com>
Subject: Re: ML403 / ALSA driver for AC97 Controller
Date: Wed, 8 Aug 2007 18:16:59 -0400
To: =?ISO-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>
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


On Aug 5, 2007, at 4:00 AM, Joachim F=F6rster wrote:

> Meanwhile, I had a _very_ short look into ASoC ... and I don't really
> know ... My driver already uses the AC97 Layer of ALSA, so in some way
> the codec is already separated from the controller. Xilinx' AC97
> Controller Reference does have some very bad impact on the codec which
> forced me to implement codec register shadowing ... hmmmm, I have to
> look at it (ASoC) again - as soon as there is more (free)time ...

I've written an ASoC driver (not yet published, though).  ASoC is =20
good when the codec is mix-and-match with the transport mechanism (eg =20=

I2S or AC97), and the transport hardware is physically separate from =20
the DMA hardware.  Now, I don't know much about AC97 or the AC97 =20
driver in ALSA, so I can't tell you whether AC97 drivers in general =20
should be ASoC.

I'm on vacation this week.  Can you send me an email with a pointer =20
to your source code, because I think I lost the original post on this =20=

thread?  I'll take a look at it next week and let you know whether =20
you should consider ASoC.

Also, ALSA patches should be posted against the head of the ALSA =20
Mercurial tree, not Linus' 2.6.22 branch, which is already outdated =20
by ALSA standards.  And we should be having this conversation on alsa-=20=

devel.
