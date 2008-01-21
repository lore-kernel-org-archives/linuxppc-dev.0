Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 671BEDDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 22:38:50 +1100 (EST)
Message-Id: <20080121103434.397382000@sunsite.dk>
Date: Mon, 21 Jan 2008 11:34:34 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
Subject: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
USB controllers. This patch series implements a HCD driver and shows the
work-in-progress status of a gadget driver.

I believe patch 1..3 are ready, and I would like to see queued up for 2.6.25.

Changes since v3:
- Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
- The dummy platform_device's created per serial engine are gone.
- Gadget driver (WIP)

Comments are very much appreciated.

--
Bye, Peter Korsgaard
