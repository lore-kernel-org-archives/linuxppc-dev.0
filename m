Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1B5BB718C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Nov 2010 23:01:28 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH 3/3] powerpc: pcm030/032: add pagesize to dts
Date: Wed, 17 Nov 2010 13:00:50 +0100
Message-Id: <1289995250-17927-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/boot/dts/pcm030.dts |    1 +
 arch/powerpc/boot/dts/pcm032.dts |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 8a4ec30..e7c36bc 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -259,6 +259,7 @@
 			eeprom@52 {
 				compatible = "catalyst,24c32";
 				reg = <0x52>;
+				pagesize = <32>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index 85d857a..e175e2c 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -257,8 +257,9 @@
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "at24,24c32";
+				compatible = "catalyst,24c32";
 				reg = <0x52>;
+				pagesize = <32>;
 			};
 		};
 
-- 
1.7.2.3
