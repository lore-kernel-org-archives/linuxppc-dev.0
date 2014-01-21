Return-Path: <Yuantian.Tang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E30F2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 14:00:44 +1100 (EST)
From: Tang Yuantian <Yuantian.Tang@freescale.com>
To: <b07421@freescale.com>
Subject: [PATCH] clk: corenet: Update the clock bindings
Date: Tue, 21 Jan 2014 10:02:12 +0800
Message-ID: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <yuantian.tang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, b32579@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Main changs include:
	- Clarified the clock nodes' version number
	- Fixed a issue in example

Singed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/clock/corenet-clock.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
index 24711af..d6cadef 100644
--- a/Documentation/devicetree/bindings/clock/corenet-clock.txt
+++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
@@ -54,6 +54,8 @@ Required properties:
 		It takes parent's clock-frequency as its clock.
 	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
 		It takes parent's clock-frequency as its clock.
+	Note: v1.0 and v2.0 are clock version which should align to
+	clockgen node's they belong to which is chassis version.
 - #clock-cells: From common clock binding. The number of cells in a
 	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
 	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
@@ -85,7 +87,7 @@ Example for clock block and clock provider:
 			#clock-cells = <0>;
 			compatible = "fsl,qoriq-sysclk-1.0";
 			clock-output-names = "sysclk";
-		}
+		};
 
 		pll0: pll0@800 {
 			#clock-cells = <1>;
-- 
1.8.0
