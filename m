Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8931D1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:50:00 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <Priyanka.Jain@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng
 <dongsheng.wang@freescale.com>
Subject: [PATCH v2 1/2] powerpc/85xx: Add binding for SCFG
Date: Fri, 14 Aug 2015 11:12:09 +0800
Message-ID: <1439521930-28191-1-git-send-email-dongsheng.wang@freescale.com>
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

From: Wang Dongsheng <dongsheng.wang@freescale.com>

SCFG provides SoC specific configuration and status registers for
the chip. Add this for powerpc platform.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*V2*
- Remove scfg description in board.txt and create scfg.txt for scfg.
- Change "fsl,<board>-scfg" to "fsl,<chip>-scfg"

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt b/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
new file mode 100644
index 0000000..0532c46
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
@@ -0,0 +1,18 @@
+Freescale Supplement configuration unit (SCFG)
+
+SCFG is the supplemental configuration unit, that provides SoC specific
+configuration and status registers for the chip. Such as getting PEX port
+status.
+
+Required properties:
+
+- compatible: should be "fsl,<chip>-scfg"
+- reg: should contain base address and length of SCFG memory-mapped
+registers
+
+Example:
+
+	scfg: global-utilities@fc000 {
+		compatible = "fsl,t1040-scfg";
+		reg = <0xfc000 0x1000>;
+	};
-- 
2.1.0.27.g96db324
