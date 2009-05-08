Return-Path: <galak@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Update FSL esdhc binding
Date: Fri,  8 May 2009 08:51:05 -0500
Message-Id: <1241790665-3680-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated the binding spec to use "fsl,eshdc" as the base compatible
rather than the first chip in the family.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
index 6008465..421897d 100644
--- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -5,8 +5,7 @@ for MMC, SD, and SDIO types of memory cards.
 
 Required properties:
   - compatible : should be
-    "fsl,<chip>-esdhc", "fsl,mpc8379-esdhc" for MPC83xx processors.
-    "fsl,<chip>-esdhc", "fsl,mpc8536-esdhc" for MPC85xx processors.
+    "fsl,<chip>-esdhc", "fsl,esdhc"
   - reg : should contain eSDHC registers location and length.
   - interrupts : should contain eSDHC interrupt.
   - interrupt-parent : interrupt source phandle.
@@ -15,7 +14,7 @@ Required properties:
 Example:
 
 sdhci@2e000 {
-	compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+	compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc", "fsl,esdhc";
 	reg = <0x2e000 0x1000>;
 	interrupts = <42 0x8>;
 	interrupt-parent = <&ipic>;
-- 
1.6.0.6
