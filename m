Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39E6EDDDFC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 05:15:41 +1100 (EST)
Date: Mon, 5 Nov 2007 12:15:35 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc: document rgmii-rxid and rgmii-txid
	phy-connection-types
Message-Id: <20071105121535.c423d095.kim.phillips@freescale.com>
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

A h/w bug requires we program the PHY in RGMII mode for internal delay
on the receive or transmit side only; document the new property values.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a96e853..b97721c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1634,8 +1634,9 @@ platforms are moved over to use the flattened-device-tree model.
      MAC addresses passed by the firmware when no information other
      than indices is available to associate an address with a device.
    - phy-connection-type : a string naming the controller/PHY interface type,
-     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "tbi",
-     or "rtbi".
+     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id" (Internal
+     Delay), "rgmii-txid" (delay on TX only), "rgmii-rxid" (delay on RX only),
+     "tbi", or "rtbi".
 
    Example:
 	ucc@2000 {
-- 
1.5.2.2
