Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06E52B7D41
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:59:27 +1000 (EST)
Date: Tue, 27 Apr 2010 21:59:24 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
Message-ID: <20100427205924.GC15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BD74D0C.40303@freescale.com>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 03:46:04PM -0500, Timur Tabi wrote:

[Reflowed into 80 columns; please fix your mail client.]

> > (I've omitted the DMA nodes and some irrelevant details)  This is
> > enough information for a simplistic driver registration that probably
> > makes a lot of assumptions.  Such as the ssi represents a single
> > logical sound device.  It won't handle complex representations, but in

> Why would I ever represent the SSI as anything but a single logical
> sound device?  Let ALSA handle synchronizing multiple streams together
> if it wants to.

...

> > 		dai-links = <&ssi1 0 &codec 0
> >                            &ssi1 1 &codec 1>;
> > 		[...]

> I don't know when I would ever do this.  The two SSI devices are
> completely independent.  Why would I bind them together into one
> "device"?

It's entirely possible that if the board designer intended the verious
SSIs to be used in concert they've done something like cross wire the
clocks which creates a board-specific interrelationship that needs to be
dealt with.
