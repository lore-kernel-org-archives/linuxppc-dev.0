Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55AFFDE29B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:09:43 +1000 (EST)
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080715124013.GA13086@polina.dev.rtsoft.ru>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 13:54:30 +0100
Message-Id: <1216126470.5345.55.camel@dax.rpnet.com>
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

On Tue, 2008-07-15 at 16:40 +0400, Anton Vorontsov wrote:
> Despite leds-gpio and leds-of-gpio similar names and purposes, there
> is not much code can be shared between the two drivers (both are mostly
> driver bindings anyway).

I don't have any issue with the driver itself, just the name which is
going to confuse people no end.

Can we come up with a better name for this driver please?
"dts-bind-gpio"? "openfirmware-led"?

I'm mainly concerned with the more user visible bits like the name of
the .c file, the wording of the Kconfig option and the module
description. We need to play down the GPIO bit and play up the
openfirmware bindings bit.

As an example the Kconfig says "LED Support for GPIO connected LEDs"
which its not, the bit about openfirmware bindings is in brackets and
hence looks incidental.

Cheers,

Richard
