Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA23D1401AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 13:14:54 +1000 (EST)
From: <Yuantian.Tang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2] clk: qoriq: Update the clock bindings
Date: Thu, 8 May 2014 11:12:10 +0800
Message-ID: <1399518730-40458-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Tang
 Yuantian <yuantian.tang@freescale.com>
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
v2:
	- rename this binding
	- rewrite the description

 .../bindings/clock/{corenet-clock.txt => qoriq-clock.txt}      | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{corenet-clock.txt => qoriq-clock.txt} (95%)

diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
similarity index 95%
rename from Documentation/devicetree/bindings/clock/corenet-clock.txt
rename to Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 24711af..5666812 100644
--- a/Documentation/devicetree/bindings/clock/corenet-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -7,6 +7,14 @@ which can then be passed to a variety of internal logic, including
 cores and peripheral IP blocks.
 Please refer to the Reference Manual for details.
 
+All references to "1.0" and "2.0" refer to the QorIQ chassis version to
+which the chip complies.
+
+Chassis Version		Example Chips
+---------------		-------------
+1.0			p4080, p5020, p5040
+2.0			t4240, b4860, t1040
+
 1. Clock Block Binding
 
 Required properties:
@@ -85,7 +93,7 @@ Example for clock block and clock provider:
 			#clock-cells = <0>;
 			compatible = "fsl,qoriq-sysclk-1.0";
 			clock-output-names = "sysclk";
-		}
+		};
 
 		pll0: pll0@800 {
 			#clock-cells = <1>;
-- 
1.8.5
