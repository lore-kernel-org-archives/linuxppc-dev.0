Return-Path: <b08308@lc1105.zin33.ap.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14FF2B7C00
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 18:31:23 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB87VK82002935
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 00:31:20 -0700 (MST)
From: Vivek Mahajan <vivek.mahajan@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/fsl: 85xx: document cache sram bindings
Date: Tue,  8 Dec 2009 13:01:15 +0530
Message-Id: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
Cc: kumar.gala@freescale.com, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds binding documentation for cache sram for the PQ3 and
some QorIQ based platforms.

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
 .../powerpc/dts-bindings/fsl/85xx_cache_sram.txt   |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt

diff --git a/Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt b/Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt
new file mode 100644
index 0000000..781955f
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt
@@ -0,0 +1,20 @@
+* Freescale PQ3 and QorIQ based Cache SRAM
+
+Freescale's mpc85xx and some QorIQ platforms provide an
+option of configuring a part of (or full) cache memory
+as SRAM. This cache SRAM representation in the device
+tree should be done as under:-
+
+Required properties:
+
+- compatible : should be "fsl,p2020-cache-sram"
+- fsl,cache-sram-ctlr-handle : points to the L2 controller
+- reg : offset and length of the cache-sram.
+
+Example:
+
+cache-sram@fff00000 {
+	fsl,cache-sram-ctlr-handle = <&L2>;
+	reg = <0 0xfff00000 0 0x10000>;
+	compatible = "fsl,p2020-cache-sram";
+};
-- 
1.5.6.5
