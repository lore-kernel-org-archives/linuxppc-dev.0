Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 053D9DE5B7
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:44:12 +1000 (EST)
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
From: Richard Purdie <rpurdie@rpsys.net>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080715142354.GA3296@polina.dev.rtsoft.ru>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
	<1216126470.5345.55.camel@dax.rpnet.com>
	<20080715132438.GA26648@polina.dev.rtsoft.ru>
	<1216128687.5345.61.camel@dax.rpnet.com>
	<20080715142354.GA3296@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 15:43:52 +0100
Message-Id: <1216133032.5345.73.camel@dax.rpnet.com>
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

On Tue, 2008-07-15 at 18:23 +0400, Anton Vorontsov wrote:
> > Spell out openfirmware :). I initially had no idea "of == openfirmware"
> > and I suspect others won't either...
> 
> This would be unusually long name, that is
> 
> $ find . -iname '*openfirmware*' | wc -l
> 0
> 
> And in contrast:
> 
> drivers/video/offb.c
> drivers/video/nvidia/nv_of.c
> drivers/usb/host/ohci-ppc-of.c
> drivers/usb/host/ehci-ppc-of.c
> drivers/serial/of_serial.c
> drivers/mtd/maps/physmap_of.c
> ...
> 
> So, I think we should stick with the "of" for consistency, while
> confused users may consult with Kconfig for disambiguation.

The other cases don't have a gpio driver to confuse this new driver
with. Lets spell it out please, the filesystems can handle the extra
letters :).

Cheers,

Richard
