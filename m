Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 27ADEDDF83
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 20:03:56 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 8871A1C01F53
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:57:19 +0100 (CET)
Received: from lancy.denx.de (p4FE63FB4.dip.t-dialin.net [79.230.63.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 8AC3590247
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:57:18 +0100 (CET)
Message-ID: <49BE146D.5050604@grandegger.com>
Date: Mon, 16 Mar 2009 09:57:17 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] PowerPC: MPC85xx: TQM8548: use proper phy-handles for
	enet2 and enet3
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For enet2 and enet3 the wrong phy-handles have been used in DTS files
of the TQM8548 modules.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
 arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index dd43dbe..29a2b6f 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -262,7 +262,7 @@
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
-			phy-handle = <&phy3>;
+			phy-handle = <&phy4>;
 		};
 
 		enet3: ethernet@27000 {
@@ -275,7 +275,7 @@
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
-			phy-handle = <&phy4>;
+			phy-handle = <&phy5>;
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index b949a8c..81d3fbb 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -262,7 +262,7 @@
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
-			phy-handle = <&phy3>;
+			phy-handle = <&phy4>;
 		};
 
 		enet3: ethernet@27000 {
@@ -275,7 +275,7 @@
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
-			phy-handle = <&phy4>;
+			phy-handle = <&phy5>;
 		};
 
 		serial0: serial@4500 {
-- 
1.6.0.6
