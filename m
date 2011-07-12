Return-Path: <sr@denx.de>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
	[IPv6:2a01:238:20a:202:53f5::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8646AB6F7A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 21:38:20 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Use correct phy-address dt nodes on taishan.dts
Date: Tue, 12 Jul 2011 13:25:54 +0200
Message-Id: <1310469954-6061-1-git-send-email-sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Taishan (440GX) has the first PHY (EMAC2) mapped at PHY address 1
and the 2nd PHY (EMAC3) at PHY address 3. Use "phy-address" to
correctly describe this instead of "phy-map".

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/taishan.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 058438f..1657ad0 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -337,7 +337,7 @@
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <0x00000001>;
+				phy-address = <1>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
  				zmii-device = <&ZMII0>;
@@ -361,7 +361,7 @@
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <0x00000003>;
+				phy-address = <3>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
  				zmii-device = <&ZMII0>;
-- 
1.7.6
