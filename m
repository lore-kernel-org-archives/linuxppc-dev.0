Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	by ozlabs.org (Postfix) with ESMTP id 493D2DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:09:43 +1100 (EST)
Message-Id: <20080124144706.041042000@sunsite.dk>
Date: Thu, 24 Jan 2008 15:47:06 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
Subject: [patch v5 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
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

Changes since v4:
 - Addressed Grant's comments (c67x00_dev->c67x00_hcd_dev, label indent)
 - Moved c67x00_ll_set_ep_{ctrl,packet_size}_reg() to patch 4 as they are
   only needed for gadget support.
 - Added c67x00_ prefix to struct lcp_int_data

--
Bye, Peter Korsgaard
