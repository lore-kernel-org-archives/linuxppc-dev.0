Return-Path: <wg@grandegger.com>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/4] [POWERPC] 85xx: correct vendor prefix in DTS files for
	TQM85xx modules
Date: Fri,  6 Jun 2008 13:50:03 +0200
Message-Id: <1212753006-994-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1212753006-994-1-git-send-email-wg@grandegger.com>
References: <1212753006-994-1-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Like for the TQM5200, the vendor prefix "tqc," is now used for all
TQM85xx modules from TQ-Components GmbH (http://www.tqc.de) in the
corresponding DTS files.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8540.dts     |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts     |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts     |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts     |    4 ++--
 arch/powerpc/platforms/85xx/tqm85xx.c |    8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8540.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
@@ -12,8 +12,8 @@
 /dts-v1/;
 
 / {
-	model = "tqm,8540";
-	compatible = "tqm,8540", "tqm,85xx";
+	model = "tqc,tqm8540";
+	compatible = "tqc,tqm8540";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8541.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8541.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8541.dts
@@ -12,8 +12,8 @@
 /dts-v1/;
 
 / {
-	model = "tqm,8541";
-	compatible = "tqm,8541", "tqm,85xx";
+	model = "tqc,tqm8541";
+	compatible = "tqc,tqm8541";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8555.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8555.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8555.dts
@@ -12,8 +12,8 @@
 /dts-v1/;
 
 / {
-	model = "tqm,8555";
-	compatible = "tqm,8555", "tqm,85xx";
+	model = "tqc,tqm8555";
+	compatible = "tqc,tqm8555";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8560.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8560.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8560.dts
@@ -12,8 +12,8 @@
 /dts-v1/;
 
 / {
-	model = "tqm,8560";
-	compatible = "tqm,8560", "tqm,85xx";
+	model = "tqc,tqm8560";
+	compatible = "tqc,tqm8560";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
Index: linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/platforms/85xx/tqm85xx.c
+++ linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -165,10 +165,10 @@ static int __init tqm85xx_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if ((of_flat_dt_is_compatible(root, "tqm,8540")) ||
-	    (of_flat_dt_is_compatible(root, "tqm,8541")) ||
-	    (of_flat_dt_is_compatible(root, "tqm,8555")) ||
-	    (of_flat_dt_is_compatible(root, "tqm,8560")))
+	if ((of_flat_dt_is_compatible(root, "tqc,tqm8540")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,tqm8541")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,tqm8555")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,tqm8560")))
 		return 1;
 
 	return 0;
