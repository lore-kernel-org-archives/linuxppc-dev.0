Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s16.bay0.hotmail.com (bay0-omc2-s16.bay0.hotmail.com
	[65.54.246.152]) by ozlabs.org (Postfix) with ESMTP id 9374EDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 01:31:49 +1100 (EST)
Message-ID: <BLU106-W44CB6B7081E03D2DC3BD83CA820@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC5200B: Linux does not recognise the external PCI card
Date: Thu, 15 Nov 2007 15:31:47 +0100
In-Reply-To: <200711151521.43047.jbe@pengutronix.de>
References: <200711151430.05943.jbe@pengutronix.de>
	<BLU106-W38B9242918AC024D3BEBB6CA820@phx.gbl>
	<200711151521.43047.jbe@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





------------------------------------------------------------------ Todas mi=
s chorradas alemanas en: http://carcadiz.blogspot.com ---------------------=
---------------------------------------------

----------------------------------------
> From: jbe@pengutronix.de
> To: linuxppc-embedded@ozlabs.org
> Date: Thu, 15 Nov 2007 15:21:41 +0100
> CC: carcadiz@hotmail.com
> Subject: Re: MPC5200B: Linux does not recognise the external PCI card
>=20
> On Thursday 15 November 2007 14:49, Pedro Luis D. L. wrote:
>>> [...]
>>> PCI: Probing PCI hardware
>>> PCI: device 0000:00:18.0 has unknown header type 7f, ignoring.
>>> mpc52xx_pci_fixup_resources() 1057:5809
>>> [...]
>>>
>>> and does not show the external card:
>>
>> Which card?
>=20
> Its a NEC USB 2.0 card.
>=20
>> Is its driver supported by the kernel?
>=20
> I think so.
>=20
>> Is it enabled inside the kernel image?
>=20
> But until the card gets recognised it makes no sense to play with the dri=
ver.

Does it? It looks to me that the kernel detects an attached device to the P=
CI interface, but doesn't know wich one.
May that be the reason why it says "PCI: device 0000:00:18.0 has unknown he=
ader type 7f, ignoring."?

>> Did you add the PCI bridge in platform configuration file? I
>> suppose so if there is a PCI probing test. I added an external ethernet
>> device and had no problem to made it work with 2.6.22 kernel.
>=20
> My kernel is a 2.6.23.1
>=20
> Juergen

Pedro.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=
