Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD2FD1A0644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 02:36:26 +1100 (AEDT)
Date: Mon, 12 Jan 2015 10:27:50 -0500
From: Martin Hicks <mort@bork.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl: Add empty ranges to etsec2 dts files
Message-ID: <20150112152749.GA5450@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



With an earlier change (746c9e9f - Fix PowerPC address parsing hack), ethernet
has broken on Freescale boards such as the P1022.  All ranges used by the
ethernet controllers are also covered by sub-devices that properly
declared the used ranges.  The error shown is:

fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -12

Signed-off-by: Martin Hicks <mort@bork.org>
---
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |    1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
index 1382fec..d1a6c48 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -43,6 +43,7 @@ mdio@24000 {
 ethernet@b0000 {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	ranges = <>;
 	device_type = "network";
 	model = "eTSEC";
 	compatible = "fsl,etsec2";
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
index 221cd2e..0447d38 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
@@ -43,6 +43,7 @@ mdio@25000 {
 ethernet@b1000 {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	ranges = <>;
 	device_type = "network";
 	model = "eTSEC";
 	compatible = "fsl,etsec2";
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
index 61456c3..d2b7255 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
@@ -42,6 +42,7 @@ mdio@26000 {
 ethernet@b2000 {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	ranges = <>;
 	device_type = "network";
 	model = "eTSEC";
 	compatible = "fsl,etsec2";
-- 
1.7.10.4
