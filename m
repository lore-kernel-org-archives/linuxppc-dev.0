Return-Path: <b56067@lvd5587.freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0068.outbound.protection.outlook.com [157.56.110.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQwZS3LZRzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:39:11 +1000 (AEST)
From: Sriram Dash <sriram.dash@nxp.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <robh@kernel.org>, <benh@kernel.crashing.org>, <rajesh.bhagat@nxp.com>,
 Sriram Dash <sriram.dash@freescale.com>, Sriram Dash <sriram.dash@nxp.com>
Subject: [PATCH] T4/B4: add aliases for usb nodes
Date: Fri, 10 Jun 2016 13:36:39 +0530
Message-ID: <1465545999-22010-1-git-send-email-sriram.dash@nxp.com>
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

From: Sriram Dash <sriram.dash@freescale.com>

Add usb aliases for consistency with the other platforms.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi        | 1 +
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi        | 1 +
 arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi        | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index bc3bf93..88d8423 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -51,6 +51,7 @@
 		serial2 = &serial2;
 		serial3 = &serial3;
 		pci0 = &pci0;
+		usb0 = &usb0;
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 8797ce1..f3f968c 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -51,6 +51,7 @@
 		serial2 = &serial2;
 		serial3 = &serial3;
 		pci0 = &pci0;
+		usb0 = &usb0;
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
diff --git a/arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi b/arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi
index 29dad72..fcc7e5b 100644
--- a/arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-usb@210000 {
+usb0: usb@210000 {
 	compatible = "fsl-usb2-dr";
 	reg = <0x210000 0x1000>;
 	#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 1184a74..038cf8f 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -56,6 +56,8 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		usb0 = &usb0;
+		usb1 = &usb1;
 		dma0 = &dma0;
 		dma1 = &dma1;
 		dma2 = &dma2;
-- 
2.6.2.198.g614a2ac
