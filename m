Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 474652BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 02:45:20 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id 106883C7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Dec 2004 16:45:19 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 10 Dec 2004 16:45:18 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055AE7@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: video card for Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Clemens,

Clemens Koller wrotes on Freitag, 10. Dezember 2004 16:11:
> > From the silicon motion homepage you could get a framebuffer driver
> > for the SM501 PCI card. This should work without great
> > modifications for PPC systems.
>=20
> Thank you, I know that thing. I started with that driver, but I did
> quite a lot of code cleanup (I guess there are lots of leftovers from
> the SM7xx parts). I am about to put this into a loadable
> kernel module fbdev driver.
> Later on, we might need some power management, use it on
> different resolutions and use the other on-chip peripherals...

Oh, sounds interesting. We took the driver from SMI and hacked it
to run on our board. Three different resolutions are possible:
640x480, 800x600 and 1024x768. We use "fbset" to change it.
But with the higher two resolutions, the picture is very noise.=20
I think this is because of two high SM501 internal memory clocks.
Unforunately the datasheet of the grafic controler is very spare -
not to say poor. So I yet couldn't figure out, at wich speed the
memory clock is running actually and how to change it.

> Do you use any of the other peripherals of the SM501, too? (USB,
> Audio, 8051)=20

No, actually not.

Regards,
Martin
