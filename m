Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9B7E1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 13:47:49 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <scottwood@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v3]devicetree/binding/powerpc/fsl: Add binding for CPLD
Date: Wed, 9 Jul 2014 09:17:07 +0530
Message-ID: <1404877627-1839-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some Freescale boards like T1040RDB have an on board CPLD connected on
the IFC bus. Add binding for cpld in board.txt file

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
Changes for v2: Incorporated Scott's comments

 .../devicetree/bindings/powerpc/fsl/board.txt      |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
index 700dec4..67ef6a4 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
@@ -84,3 +84,19 @@ Example:
 		compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
 		reg = <0x66>;
 	};
+
+* Freescale on-board CPLD
+
+Some Freescale boards like T1040RDB have an on board CPLD connected.
+
+Required properties:
+- compatible: Should be a board-specific string like "fsl,<board>-cpld"
+  Example:
+	"fsl,t1040rdb-cpld", "fsl,t1042rdb-cpld", "fsl,t1042rdb_pi-cpld"
+- reg: should describe CPLD registers
+
+Example:
+	cpld@3,0 {
+		compatible = "fsl,t1040rdb-cpld";
+		reg = <3 0 0x300>;
+	};
-- 
1.7.4.1
