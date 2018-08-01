Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gTXl4RV2zF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 20:08:37 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 2/3] powerpc/mpc85xx: add clocks property for fman ptp timer node
Date: Wed,  1 Aug 2018 18:05:53 +0800
Message-Id: <20180801100554.36634-2-yangbo.lu@nxp.com>
In-Reply-To: <20180801100554.36634-1-yangbo.lu@nxp.com>
References: <20180801100554.36634-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to add clocks property for fman ptp timer node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index 6b124f7..9b6cf91 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -100,4 +100,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index b80aaf5..e95c11f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -100,4 +100,5 @@ ptp_timer1: ptp-timer@5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index d3720fd..d62b36c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -105,4 +105,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index ae34c20..3102324 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -105,4 +105,5 @@ ptp_timer1: ptp-timer@5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 02f2755..c90702b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -93,4 +93,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
-- 
1.7.1
