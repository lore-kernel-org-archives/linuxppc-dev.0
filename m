Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 707492C04BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:29:43 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/mpc8572ds: Update the MSI interrupts into 4-cell
 format
Date: Tue, 10 Jul 2012 14:08:26 +0800
Message-ID: <1341900506-23401-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1341900506-23401-1-git-send-email-B38951@freescale.com>
References: <1341900506-23401-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With 2-cell format interrupts of MSI PCIe ethernet card can not work.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    8 ++++----
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index d34d127..ef9ef56 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -67,10 +67,10 @@
 		msi@41600 {
 			msi-available-ranges = <0 0x80>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0>;
 		};
 		timer@42100 {
 			status = "disabled";
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index 1932396..24564ee 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -97,10 +97,10 @@
 		msi@41600 {
 			msi-available-ranges = <0x80 0x80>;
 			interrupts = <
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 		global-utilities@e0000 {
 			status = "disabled";
-- 
1.7.5.1
