Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 327E8DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 20:36:50 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9G9aiQe027743
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 02:36:44 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m9G9agkG026989
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 04:36:43 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] Enable enhanced functions for 8536 TSEC
Date: Thu, 16 Oct 2008 17:31:32 +0800
Message-Id: <1224149492-11204-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 93fdd99..dce2f65 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -180,7 +180,7 @@
 		enet0: ethernet@24000 {
 			cell-index = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
@@ -193,7 +193,7 @@
 		enet1: ethernet@26000 {
 			cell-index = <1>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-- 
1.5.4
