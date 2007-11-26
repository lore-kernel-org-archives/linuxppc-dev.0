Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C153DDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:17:55 +1100 (EST)
Date: Mon, 26 Nov 2007 16:17:48 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 1/3][RESEND] phylib: add PHY interface modes for internal
	delay for tx and rx only
Message-Id: <20071126161748.9671b828.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
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
Tested-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Li Yang <leoli@freescale.com>
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
