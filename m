Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s25.bay0.hotmail.com (bay0-omc2-s25.bay0.hotmail.com
	[65.54.246.161]) by ozlabs.org (Postfix) with ESMTP id 36CB1DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 21:38:59 +1000 (EST)
Message-ID: <BLU106-W94EC8F5D652CCD450801ACAB90@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] phy: export phy_mii_ioctl
Date: Wed, 19 Sep 2007 13:38:58 +0200
In-Reply-To: <200709191238.00183.jbe@pengutronix.de>
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709181229m4afe7ecr56e2411f52a84232@mail.gmail.com>
	<BLU106-W49D16A32DDFE2611E15371CAB90@phx.gbl>
	<200709191238.00183.jbe@pengutronix.de>
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


Juergen wrote:

>
>Pedro,
>
>On Wednesday 19 September 2007 10:54, Pedro Luis D. L. wrote:
>> I=B4m also working with a Phytec pcm030, but I can=B4t get it booted...
>> Which kernel are you using?
>> I tried to apply the 7 bestcomm patches from Sylvain and patch over thes=
e
>> with this new ones that Domen released. The base kernel I=B4m using is
>> 2.6.22.6 from kernel.org.
>> Although I used the patch that creates pcm030.c in arch/platforms/52xx/ =
and
>> compiled using this file, it gets halted at booting time.
>>
>> Bytes transferred =3D 5091 (13e3 hex)
>> ## Booting image at 00500000 ...
>>    Image Name:   Linux-2.6.22.6
>>    Created:      2007-09-19   8:53:02 UTC
>>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>    Data Size:    1196911 Bytes =3D  1.1 MB
>>    Load Address: 00000000
>>    Entry Point:  00000000
>>    Verifying Checksum ... OK
>>    Uncompressing Kernel Image ... OK
>>    Booting using flat device tree at 0x400000
>>
>> (No more output and boot is halted)
>=20
>Check your oftree! Most of the time this behaviour means its a wrong oftre=
e in=20
>use.

I=B4m using an specific pcm030.dts oftree that works for the 2.6.20 kernel.=
 I=B4m not quite familiar with the oftree stuff, but I thought it should wo=
rk also for the 2.6.22.6.
Is there any other dts file? Where can I find it?

Pedro.

PD: Sorry. I sent the previous message to Jon, Domen and someone else too b=
esides the list. I had some problems with the browser... Even sent twice th=
e message :-(

>Juergen
>=20
>--=20
>Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister: Amtsgericht Hildesheim, HRA 2686
>        Vertretung Sued/Muenchen, Germany
>   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
>

_________________________________________________________________
Llama a tus amigos de PC a PC: =A1Es GRATIS!
http://get.live.com/messenger/overview=
