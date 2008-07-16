Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B658DE54A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:23:11 +1000 (EST)
Date: Wed, 16 Jul 2008 16:22:17 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH v2] leds: implement OpenFirmare GPIO LED driver
In-Reply-To: <1216133032.5345.73.camel@dax.rpnet.com>
Message-ID: <Pine.LNX.4.64.0807161619050.12709@t2.domain.actdsltmp>
References: <20080715123822.GA10893@polina.dev.rtsoft.ru>
	<20080715124013.GA13086@polina.dev.rtsoft.ru>
	<1216126470.5345.55.camel@dax.rpnet.com>
	<20080715132438.GA26648@polina.dev.rtsoft.ru>
	<1216128687.5345.61.camel@dax.rpnet.com>
	<20080715142354.GA3296@polina <1216133032.5345.73.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 15 Jul 2008, Richard Purdie wrote:
> On Tue, 2008-07-15 at 18:23 +0400, Anton Vorontsov wrote:
>>> Spell out openfirmware :). I initially had no idea "of == openfirmware"
>>> and I suspect others won't either...
>>
>> This would be unusually long name, that is
>>
>> $ find . -iname '*openfirmware*' | wc -l
>> 0
>>
>> And in contrast:
>>
>> drivers/video/offb.c
>> drivers/video/nvidia/nv_of.c
>> drivers/usb/host/ohci-ppc-of.c
>> drivers/usb/host/ehci-ppc-of.c
>> drivers/serial/of_serial.c
>> drivers/mtd/maps/physmap_of.c
>> ...
>>
>> So, I think we should stick with the "of" for consistency, while
>> confused users may consult with Kconfig for disambiguation.
>
> The other cases don't have a gpio driver to confuse this new driver
> with. Lets spell it out please, the filesystems can handle the extra
> letters :).

There's drivers/mtd/maps/physmap.c and drivers/mtd/maps/physmap_of.c,
drivers/serial/of_serial.c and drivers/serial/serial_core.c,
drivers/usb/host/ehci-ppc-soc.c and drivers/usb/host/ehci-ppc-of.c, etc.
