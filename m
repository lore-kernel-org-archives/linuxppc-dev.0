Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E32BBDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 09:03:34 +1100 (EST)
Message-ID: <473387AF.6030105@freescale.com>
Date: Thu, 08 Nov 2007 16:03:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	
	<4732396D.4040904@genesi-usa.com>	
	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>	
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>	
	<473375E6.5080503@freescale.com>	
	<9e4733910711081251w392b4a84m8e81d902305bf395@mail.gmail.com>	
	<473377F8.2050802@freescale.com>
	<9e4733910711081353h43ec8978u2db4618090688010@mail.gmail.com>
In-Reply-To: <9e4733910711081353h43ec8978u2db4618090688010@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jon Smirl wrote:
> On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
>>> As far as I know the only dts using vendor prefixes in the compatible
>>> attributes is 5200lite one for the gpt entries. Everything else will
>>> need to be changed.
>> Look a little harder.  Many of the Freescale boards/devices do it right
>> -- and yes, we need to fix the ones that don't.
> 
> I see that there are quite a few with the ibm prefix. But by
> eyeballing grep output it looks like several hundred attributes need
> to be fixed. Code referencing these will need to be fixed too.

Several hundred?  I don't think there are several hundred unique 
property names or compatible entries in arch/powerpc/boot/dts *total*, 
much less that need fixing.  The main ones in fsl-land that I can think 
of are gianfar, i2c, talitos, QE, USB, tsi108, watchdog, SPI, and IPIC.

CPM1 and CPM2 devices, PCI, 85xx memory/cache controllers, and 85xx 
global utilities have the prefix.

For the most part, we've been adding prefixes whenever we have any other 
reason to touch the binding.

> If lite5200 hadn't mixed half prefixed and half not prefixed I never
> would have started looking at this.
> 
> Let's make up our minds in the lite5200 dts so that I can sync up my
> development hardware.

Patches are welcome. :-)

-Scott
