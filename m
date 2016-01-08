Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0089.outbound.protection.outlook.com [65.55.169.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 645AB1A0658
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:55:15 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <robh+dt@kernel.org>, <Priyanka.Jain@freescale.com>,
 <scottwood@freescale.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH 2/3] T1040RDB: add tdm riser card node to t1040rdb
Date: Fri, 8 Jan 2016 10:46:54 +0800
Message-ID: <1452221215-12681-2-git-send-email-qiang.zhao@nxp.com>
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

add tdm riser card node to t1040rdb.dts

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1040rdb.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index cf19415..d52b011 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -43,6 +43,16 @@
 			compatible = "fsl,t1040rdb-cpld";
 		};
 	};
+
+	soc: soc@ffe000000 {
+		spi@110000 {
+			slic@3 {
+				compatible = "maxim,ds26522";
+				reg = <3>;
+				spi-max-frequency = <2000000>; /* input clock */
+			};
+		};
+	};
 };
 
 #include "t1040si-post.dtsi"
-- 
2.1.0.27.g96db324
