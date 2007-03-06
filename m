Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id EEE6DDDF0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 20:51:42 +1100 (EST)
Date: Tue, 6 Mar 2007 10:51:39 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] lite5200(b) typos in dts
Message-ID: <20070306095139.GZ4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix lite5200(b) copy paste typos in dts.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/boot/dts/lite5200.dts  |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200.dts
@@ -179,7 +179,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -179,7 +179,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
