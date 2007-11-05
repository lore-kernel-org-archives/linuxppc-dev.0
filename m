Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56702DDE9A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 05:15:46 +1100 (EST)
Date: Mon, 5 Nov 2007 12:15:39 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] phylib: add PHY interface modes for internal delay for
	tx and rx only
Message-Id: <20071105121539.9a1d6cbb.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow phylib specification of cases where hardware needs to configure
PHYs for Internal Delay only on either RX or TX (not both).

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 include/linux/phy.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index f0742b6..e10763d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -58,6 +58,8 @@ typedef enum {
 	PHY_INTERFACE_MODE_RMII,
 	PHY_INTERFACE_MODE_RGMII,
 	PHY_INTERFACE_MODE_RGMII_ID,
+	PHY_INTERFACE_MODE_RGMII_RXID,
+	PHY_INTERFACE_MODE_RGMII_TXID,
 	PHY_INTERFACE_MODE_RTBI
 } phy_interface_t;
 
-- 
1.5.2.2
