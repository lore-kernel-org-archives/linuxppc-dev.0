Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEC42DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:31:52 +1000 (EST)
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
From: Richard Purdie <rpurdie@rpsys.net>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080715132438.GA26648@polina.dev.rtsoft.ru>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
	<1216126470.5345.55.camel@dax.rpnet.com>
	<20080715132438.GA26648@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 14:31:27 +0100
Message-Id: <1216128687.5345.61.camel@dax.rpnet.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 17:24 +0400, Anton Vorontsov wrote:
> On Tue, Jul 15, 2008 at 01:54:30PM +0100, Richard Purdie wrote:
> > I don't have any issue with the driver itself, just the name which is
> > going to confuse people no end.
> > 
> > Can we come up with a better name for this driver please?
[...]
> > "openfirmware-led"?
> 
> And this would be wrong, since this driver is for GPIO LEDs only, not
> for all LEDs that OF can describe. In future there could be OF PWM LEDs
> or something like this.

Ok, will these be a separate driver or combined into the gpio driver?

> > I'm mainly concerned with the more user visible bits like the name of
> > the .c file, the wording of the Kconfig option and the module
> > description. We need to play down the GPIO bit and play up the
> > openfirmware bindings bit.
> 
> Hm... file name is leds-of-gpio.c, how could I play up the "of" bit more
> than this? ;-)

Spell out openfirmware :). I initially had no idea "of == openfirmware"
and I suspect others won't either...

> > As an example the Kconfig says "LED Support for GPIO connected LEDs"
> > which its not, the bit about openfirmware bindings is in brackets and
> > hence looks incidental.
> 
> As for Kconfig, yeah.. probably I can improve the wording. How about
> "OpenFirmware bindings for GPIO connected LEDs"? Would that work?

Yes, thats better. I think basically we need to spell out OF a bit more.
Its probably obvious to powerpc people but not everyone else.

Cheers,

Richard
