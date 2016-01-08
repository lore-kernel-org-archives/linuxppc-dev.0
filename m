Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0081.outbound.protection.outlook.com [65.55.169.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B3781A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 13:55:02 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <robh+dt@kernel.org>, <Priyanka.Jain@freescale.com>,
 <scottwood@freescale.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH 1/3] TDM: Add maxim ds26522 document to bindings
Date: Fri, 8 Jan 2016 10:46:53 +0800
Message-ID: <1452221215-12681-1-git-send-email-qiang.zhao@nxp.com>
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

Add maxim ds26522 document to
Documentation/devicetree/bindings/tdm/maxim,ds26522.txt

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 Documentation/devicetree/bindings/tdm/maxim,ds26522.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tdm/maxim,ds26522.txt

diff --git a/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt b/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
new file mode 100644
index 0000000..3548c51
--- /dev/null
+++ b/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
@@ -0,0 +1,13 @@
+* Maxim (Dallas) DS26522 Octal T1/E1/J1 Transceiver
+
+Required properties:
+- compatible: Should contain "maxim,ds26522".
+- reg: SPI CS
+- spi-max-frequency: SPI bus max frequency.
+
+Example:
+	slic@2 {
+		compatible = "maxim,ds26522";
+		reg = <2>;
+		spi-max-frequency = <2000000>;
+	};
-- 
2.1.0.27.g96db324
