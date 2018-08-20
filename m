Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40087.outbound.protection.outlook.com [40.107.4.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vNGB1gdvzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 04:52:17 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 1/5] dt-bindings: arm64: add compatible for LX2160A
Date: Mon, 20 Aug 2018 12:17:12 +0530
Message-Id: <1534747636-20064-2-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
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

Add compatible for LX2160A SoC,QDS and RDB board

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..76256bd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -218,3 +218,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible = "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
-- 
2.7.4
