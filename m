Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 893C9DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 22:29:12 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Kipxu-000473-Ve
	for linuxppc-embedded@ozlabs.org; Thu, 25 Sep 2008 14:29:07 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 25 Sep 2008 14:29:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809251429.01633.jbe@pengutronix.de>
Subject: Watchdog usage on MPC5200B platform
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

has anybody an idea why when I'm using drivers/watchdog/mpc5200_wdt.c, the=
=20
system freezes instead of doing a restart?

When I'm running the "reboot" command it does a restart as expected.

=46or both cases the same hardware will be used (WDT in timer@600 marked=20
with "fsl,has-wdt" in the oftree).

Regards
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
