Return-Path: <wg@grandegger.com>
Message-ID: <48481DFE.6030405@grandegger.com>
Date: Thu, 05 Jun 2008 19:10:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/4] [POWERPC] 85xx: correct vendor prefix in DTS files
	for TQM85xx modules
Content-Type: text/plain; charset=ISO-8859-1
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
+	model = "tqc,8540";
+	compatible = "tqc,8540", "tqc,85xx";
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
+	model = "tqc,8541";
+	compatible = "tqc,8541", "tqc,85xx";
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
+	model = "tqc,8555";
+	compatible = "tqc,8555", "tqc,85xx";
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
+	model = "tqc,8560";
+	compatible = "tqc,8560", "tqc,85xx";
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
+	if ((of_flat_dt_is_compatible(root, "tqc,8540")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,8541")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,8555")) ||
+	    (of_flat_dt_is_compatible(root, "tqc,8560")))
 		return 1;
 
 	return 0;
