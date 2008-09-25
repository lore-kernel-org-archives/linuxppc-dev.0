Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 9E614DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 23:25:55 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1KiqqY-000528-1P
	for linuxppc-embedded@ozlabs.org; Thu, 25 Sep 2008 15:25:48 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 25 Sep 2008 15:25:27 +0200
References: <200809251429.01633.jbe@pengutronix.de>
In-Reply-To: <200809251429.01633.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809251525.28557.jbe@pengutronix.de>
Subject: Re: Watchdog usage on MPC5200B platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Donnerstag, 25. September 2008, Juergen Beisert wrote:
> has anybody an idea why when I'm using drivers/watchdog/mpc5200_wdt.c, the
> system freezes instead of doing a restart?

Once again: It does a restart with kernel 2.6.23, but not with 2.6.26. Agai=
n=20
it seems something related is not setup correctly. Any idea? I didn't find=
=20
anything special in the MPC5200B generic part of 2.6.23.

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
