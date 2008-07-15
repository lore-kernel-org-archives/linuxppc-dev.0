Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CDA7FDDFC0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:24:40 +1000 (EST)
Date: Tue, 15 Jul 2008 17:24:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080715132438.GA26648@polina.dev.rtsoft.ru>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
	<1216126470.5345.55.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1216126470.5345.55.camel@dax.rpnet.com>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 01:54:30PM +0100, Richard Purdie wrote:
> On Tue, 2008-07-15 at 16:40 +0400, Anton Vorontsov wrote:
> > Despite leds-gpio and leds-of-gpio similar names and purposes, there
> > is not much code can be shared between the two drivers (both are mostly
> > driver bindings anyway).
> 
> I don't have any issue with the driver itself, just the name which is
> going to confuse people no end.
> 
> Can we come up with a better name for this driver please?
> "dts-bind-gpio"?

Hm... I don't actually understand what this name implies.

> "openfirmware-led"?

And this would be wrong, since this driver is for GPIO LEDs only, not
for all LEDs that OF can describe. In future there could be OF PWM LEDs
or something like this.

> I'm mainly concerned with the more user visible bits like the name of
> the .c file, the wording of the Kconfig option and the module
> description. We need to play down the GPIO bit and play up the
> openfirmware bindings bit.

Hm... file name is leds-of-gpio.c, how could I play up the "of" bit more
than this? ;-)

> As an example the Kconfig says "LED Support for GPIO connected LEDs"
> which its not, the bit about openfirmware bindings is in brackets and
> hence looks incidental.

As for Kconfig, yeah.. probably I can improve the wording. How about
"OpenFirmware bindings for GPIO connected LEDs"? Would that work?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
