Return-Path: <madalin.bucur@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0040.outbound.protection.outlook.com [104.47.42.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYhrG4ZrmzDvxh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 02:15:10 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <devicetree@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <oss@buserror.net>
Subject: [PATCH v3 4/4] powerpc/fsl/dts: add FMan node for t1042d4rdb
Date: Wed, 7 Dec 2016 17:14:56 +0200
Message-ID: <1481123696-21028-4-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1481123696-21028-1-git-send-email-madalin.bucur@nxp.com>
References: <1481123696-21028-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
index 2a5a90d..fcd2aeb 100644
--- a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
@@ -48,6 +48,58 @@
 					"fsl,deepsleep-cpld";
 		};
 	};
+
+	soc: soc@ffe000000 {
+		fman0: fman@400000 {
+			ethernet@e0000 {
+				phy-handle = <&phy_sgmii_0>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy_sgmii_1>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_2>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy_rgmii_0>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_1>;
+				phy-connection-type = "rgmii";
+			};
+
+			mdio0: mdio@fc000 {
+				phy_sgmii_0: ethernet-phy@02 {
+					reg = <0x02>;
+				};
+
+				phy_sgmii_1: ethernet-phy@03 {
+					reg = <0x03>;
+				};
+
+				phy_sgmii_2: ethernet-phy@01 {
+					reg = <0x01>;
+				};
+
+				phy_rgmii_0: ethernet-phy@04 {
+					reg = <0x04>;
+				};
+
+				phy_rgmii_1: ethernet-phy@05 {
+					reg = <0x05>;
+				};
+			};
+		};
+	};
+
 };
 
 #include "t1042si-post.dtsi"
-- 
2.1.0
