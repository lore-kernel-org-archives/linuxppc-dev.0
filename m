Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 3E194DDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 19:57:17 +1000 (EST)
Message-ID: <486DF3FA.3010806@matrix-vision.de>
Date: Fri, 04 Jul 2008 11:57:14 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: s.hauer@pengutronix.de, Grant Likely <grant.likely@secretlab.ca>
Subject: GPIO @ MPC5200
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sascha, Grant,

I'm running on 2.6.26-rc6 with an MPC5200B based system.

Looks like some (for me) crucial GPIO are touched during boot.
Is this possible ?

Of course I have compiled in GPIO-Lib and specified the GPIOs in the dts.
But no access yet - I'd like to preserve the setup from u-boot...

regards,
Andre

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
