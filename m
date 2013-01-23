Return-Path: <B16394@freescale.com>
From: Vakul Garg <vakul@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>,
 <linux-crypto@vger.kernel.org>
Subject: [PATCHv1] crypto: caam - Added property fsl,
 sec-era in SEC4.0 device tree binding.
Date: Wed, 23 Jan 2013 12:51:08 +0530
Message-ID: <1358925668-10330-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This new property defines the era of the particular SEC version.
The compatible property in device tree "crypto" node has been updated
not to contain SEC era numbers.

Signed-off-by: Vakul Garg <vakul@freescale.com>
---
Changelog:
	1. Marked fsl,sec-era as 'optional'.

 .../devicetree/bindings/crypto/fsl-sec4.txt        |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index fc9ce6f..dc40055 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -54,8 +54,13 @@ PROPERTIES
    - compatible
       Usage: required
       Value type: <string>
-      Definition: Must include "fsl,sec-v4.0". Also includes SEC
-           ERA versions (optional) with which the device is compatible.
+      Definition: Must include "fsl,sec-v4.0"
+
+   - fsl,sec-era
+      Usage: optional
+      Value type: <u32>
+      Definition: A standard property. Define the 'ERA' of the SEC
+          device.
 
    - #address-cells
        Usage: required
@@ -107,7 +112,8 @@ PROPERTIES
 
 EXAMPLE
 	crypto@300000 {
-		compatible = "fsl,sec-v4.0", "fsl,sec-era-v2.0";
+		compatible = "fsl,sec-v4.0";
+		fsl,sec-era = <0x2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x300000 0x10000>;
-- 
1.7.7.6
