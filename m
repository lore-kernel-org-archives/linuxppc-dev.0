Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0056.outbound.protection.outlook.com [157.56.110.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0DCA1A0C4E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:55:16 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <robh+dt@kernel.org>, <Priyanka.Jain@freescale.com>,
 <scottwood@freescale.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH 3/3] T1040D4RDB: add tdm riser card node to t1040d4rdb
Date: Fri, 8 Jan 2016 10:46:55 +0800
Message-ID: <1452221215-12681-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1452221215-12681-1-git-send-email-qiang.zhao@nxp.com>
References: <1452221215-12681-1-git-send-email-qiang.zhao@nxp.com>
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

add tdm riser card node to t1040d4rdb.dts

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1040d4rdb.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
index fb6bc02..ee3d1ec 100644
--- a/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
@@ -41,6 +41,22 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
+
+	soc: soc@ffe000000 {
+		spi@110000 {
+			slic@1 {
+				compatible = "maxim,ds26522";
+				reg = <1>;
+				spi-max-frequency = <2000000>;
+			};
+
+			slic@2 {
+				compatible = "maxim,ds26522";
+				reg = <2>;
+				spi-max-frequency = <2000000>;
+			};
+		};
+	};
 };
 
 #include "t1040si-post.dtsi"
-- 
2.1.0.27.g96db324
