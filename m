Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B89D11A032A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 18:04:59 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-can@vger.kernel.org>,
 <wg@grandegger.com>, <mkl@pengutronix.de>, <B07421@freescale.com>
Subject: [PATCH 2/2] flexcan: add err interrupt for p1010rdb
Date: Thu, 19 Jun 2014 15:46:13 +0800
Message-ID: <1403163973-48239-2-git-send-email-B45475@freescale.com>
In-Reply-To: <1403163973-48239-1-git-send-email-B45475@freescale.com>
References: <1403163973-48239-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add err interrupt for p1010rdb into dts.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 4313ff6..bcd95ba 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -141,13 +141,15 @@
 	can0: can@1c000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1c000 0x1000>;
-		interrupts = <48 0x2 0 0>;
+		interrupts = <48 0x2 0 0
+			      16 0x2 0 0>;
 	};
 
 	can1: can@1d000 {
 		compatible = "fsl,p1010-flexcan";
 		reg = <0x1d000 0x1000>;
-		interrupts = <61 0x2 0 0>;
+		interrupts = <61 0x2 0 0
+			      16 0x2 0 0>;
 	};
 
 	L2: l2-cache-controller@20000 {
-- 
1.8.5
