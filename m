Return-Path: <SRS0=RRnR=P2=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2FDBEDDDD5
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 01:50:38 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
Date: Thu, 1 Nov 2007 15:50:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711011550.33690.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For EMAC support, 405EX needs to be defined to enable the corresponding
EMAC features (IBM_NEW_EMAC_EMAC4, etc.).

Signed-off-by: Stefan Roese <sr@denx.de>
---
A small new EMAC patch will follow in a short while, to enable
405EX support in the driver.

 arch/powerpc/platforms/40x/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 8f6699f..3ece0fd 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -33,6 +33,7 @@ config KILAUEA
 	bool "Kilauea"
 	depends on 40x
 	default n
+	select 405EX
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
 
@@ -105,6 +106,11 @@ config 405GP
 config 405EP
 	bool
 
+config 405EX
+	bool
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+
 config 405GPR
 	bool
 
-- 
1.5.3.4.498.g9c514
