Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id E0B7CB70C6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 06:33:32 +1000 (EST)
Received: by ewy2 with SMTP id 2so5640187ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 13:33:30 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] tqm85xx: update PCI interrupt-map attribute
Date: Thu, 22 Jul 2010 00:33:23 +0400
Message-Id: <1279744404-10171-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1279744404-10171-1-git-send-email-dbaryshkov@gmail.com>
References: <1279744404-10171-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update PCI IRQ mapping on TQM85xx platforms: include INTC and INTD on PCI-X
slot and add INTA/INTB mapping for PCMCIA bridge.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/tqm8540.dts          |    9 ++++++++-
 arch/powerpc/boot/dts/tqm8541.dts          |    9 ++++++++-
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    9 ++++++++-
 arch/powerpc/boot/dts/tqm8548.dts          |    9 ++++++++-
 arch/powerpc/boot/dts/tqm8555.dts          |    9 ++++++++-
 arch/powerpc/boot/dts/tqm8560.dts          |    9 ++++++++-
 6 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 7161b93..b5c0940 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -290,7 +290,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index b30f637..f49d091 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -311,7 +311,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 61f25e1..5dbb36e 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -442,7 +442,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 025759c..a050ae4 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -442,7 +442,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 95e2873..81bad8c 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -311,7 +311,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index ff70580..22ec39b 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -382,7 +382,14 @@
 		interrupt-map = <
 				/* IDSEL 28 */
 				 0xe000 0 0 1 &mpic 2 1
-				 0xe000 0 0 2 &mpic 3 1>;
+				 0xe000 0 0 2 &mpic 3 1
+				 0xe000 0 0 3 &mpic 6 1
+				 0xe000 0 0 4 &mpic 5 1
+
+				/* IDSEL 11 */
+				 0x5800 0 0 1 &mpic 6 1
+				 0x5800 0 0 2 &mpic 5 1
+				 >;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
-- 
1.7.1
