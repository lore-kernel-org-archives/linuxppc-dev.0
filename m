Return-Path: <SRS0=wK9d=QY=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 8DA5FDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 21:24:43 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
Date: Sat,  1 Dec 2007 11:19:55 +0100
Message-Id: <1196504395-24104-1-git-send-email-sr@denx.de>
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
 arch/powerpc/platforms/40x/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 66aa351..5d2ca0d 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -26,6 +26,7 @@ config KILAUEA
 	bool "Kilauea"
 	depends on 40x
 	default n
+	select 405EX
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
 
@@ -98,6 +99,11 @@ config 405GP
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
1.5.3.6.985.g65c6a4
