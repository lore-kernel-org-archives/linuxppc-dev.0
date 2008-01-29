Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	by ozlabs.org (Postfix) with ESMTP id EA7AADDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 23:48:49 +1100 (EST)
Message-Id: <20080129122430.070266000@sunsite.dk>
Date: Tue, 29 Jan 2008 13:24:30 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
Subject: [patch v6 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
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

I believe patch 1..3 are ready, and I would like to see them queued up for
2.6.25.

Changes since v5:
 - Merged c67x00_ll_{get,set}_siemsg() into c67x00_ll_fetch_siemsg().
 - Fix for interrupt race condition at probe time (reported by Grant)

Changes since v4:
 - Addressed Grant's comments (c67x00_dev->c67x00_hcd_dev, label indent)
 - Moved c67x00_ll_set_ep_{ctrl,packet_size}_reg() to patch 4 as they are
   only needed for gadget support.
 - Added c67x00_ prefix to struct lcp_int_data

Changes since v3:
- Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
- The dummy platform_device's created per serial engine are gone.
- Gadget driver (WIP)

--
Bye, Peter Korsgaard
