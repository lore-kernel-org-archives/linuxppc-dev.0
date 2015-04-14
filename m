Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DEBC1A0BD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 23:52:32 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] dt/bindings: qoriq-clock: Update core PLL binding
Date: Tue, 14 Apr 2015 12:42:29 +0300
Message-ID: <1429004550-24504-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Added optional divider to "fsl,qoriq-core-pll-2.0".
This option might be used by Freescale hardware accelerators.

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 .../devicetree/bindings/clock/qoriq-clock.txt      |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index df4a259..b0d7b73 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -68,11 +68,17 @@ Required properties:
 - #clock-cells: From common clock binding. The number of cells in a
 	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
 	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
-	For "fsl,qoriq-core-pll-[1,2].0" clocks, the single
+	For "fsl,qoriq-core-pll-1.0" clocks, the single
 	clock-specifier cell may take the following values:
 	* 0 - equal to the PLL frequency
 	* 1 - equal to the PLL frequency divided by 2
 	* 2 - equal to the PLL frequency divided by 4
+	For "fsl,qoriq-core-pll-2.0" clocks, the single
+	clock-specifier cell may take the following values:
+	* 0 - equal to the PLL frequency
+	* 1 - equal to the PLL frequency divided by 2
+	* 2 - equal to the PLL frequency divided by 3
+	* 3 - equal to the PLL frequency divided by 4
 
 Recommended properties:
 - clocks: Should be the phandle of input parent clock
-- 
1.7.9.5
