Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (port-92-198-50-35.dynamic.qsc.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7635EDDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 03:38:21 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Date: Fri, 21 Nov 2008 17:38:09 +0100
References: <200811211336.41159.jbe@pengutronix.de>
	<4926DA98.4060401@matrix-vision.de>
In-Reply-To: <4926DA98.4060401@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811211738.11049.jbe@pengutronix.de>
Subject: Re: MPC5200B: Trouble with config pins
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andre,

On Freitag, 21. November 2008, Andre Schwarz wrote:
> Have a look at the manual chapter 4 (=3DReset + Config).
> SRESET (issued by gpt0 - watchdog) isn't supposed to do a full hardware
> reset.
> Looks like you should make use of the SRESET and trigger HRESET
> accordingly.
>
> I could solve this with _not_ using the internal watchdog but an
> external one (TPS3828),
> i.e. watchdog timeouts and reboots are always issued by PORESET.

We are using an external watchdog now. But same behaviour. It hurts less,=20
because we increase the length of the active reset signal to add more time =
to=20
let the pin "find" its low level. But I'm not really happy about this=20
solution...

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
