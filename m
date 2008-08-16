Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B7D08DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 12:41:02 +1000 (EST)
Received: from octopus.labnet.pengutronix.de ([10.1.1.3])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>) id 1KUBip-0004js-F1
	for linuxppc-embedded@ozlabs.org; Sat, 16 Aug 2008 04:40:55 +0200
Received: from wsa by octopus.labnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <w.sang@pengutronix.de>) id 1KUBip-0004H5-5w
	for linuxppc-embedded@ozlabs.org; Sat, 16 Aug 2008 04:40:55 +0200
Message-Id: <20080816023159.126377505@pengutronix.de>
Date: Sat, 16 Aug 2008 04:31:59 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [patch 0/2] FEC_MPC52XX_PHY: Updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

While debugging FEC-problems, I encountered some issues in the FEC_PHY
driver.

- Patch 1 removes some obsolete code remaining from a (according to old
  mails) broken attempt to handle irqs.
- Patch 2 refactors read/write routines to use common code, so updates
  regarding bus transfers just have to be made once.

Tested on a Phytec phyCORE-MPC5200B-IO board.

All the best,

   Wolfram

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
