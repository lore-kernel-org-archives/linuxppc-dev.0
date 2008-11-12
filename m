Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 82B0EDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 21:52:01 +1100 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1L0DK7-0003gv-4r
	for linuxppc-dev@ozlabs.org; Wed, 12 Nov 2008 11:51:52 +0100
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Wed, 12 Nov 2008 11:51:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811121151.45208.jbe@pengutronix.de>
Subject: Using gpiolib to power off my system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi list,

I want to use the gpiolib API in a routine that should poweroff the system=
=20
(MPC5200B). I register my poweroff routine in the define_machine() macro as:

[...]
=2Epower_off	=3D my_power_off,
[...]

In this routine I'm using gpio_request(...), gpio_direction_output(...) and=
=20
gpio_set_value(...) ---- but nothing happens.

When I set the GPIOs in the hard way (ioremap() + playing with the register=
s)=20
the system switches off as expected.

How to get some useful debug output at this late system state (printk does =
not=20
work anymore)?

Regards,
Juergen
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
