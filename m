Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36C4D1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 18:47:47 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
Subject: [PATCH] devicetree/bindings/powerpc/fsl: Add binding for board
Date: Mon, 7 Jul 2014 14:06:34 +0530
Message-ID: <1404722194-8103-1-git-send-email-Priyanka.Jain@freescale.com>
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

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/board.txt      |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
index f35f295..7800729 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
@@ -1,8 +1,23 @@
 Freescale Reference Board Bindings
 
-This document describes device tree bindings for various devices that
+This document describes device tree bindings for board and  various devices that
 exist on some Freescale reference boards.
 
+* Board node
+Required properties:
+
+ - model : Should be "fsl,<board>"
+ - compatible : Should be "fsl,<board>"
+	example: "fsl,T1040RDB", "fsl,T1042RDB", "fsl,T1042RDB_PI"
+		 "fsl,T1040QDS", "fsl,T1042QDS"
+
+Example:
+
+/ {
+	model = "fsl,T1040RDB";
+	compatible = "fsl,T1040RDB";
+};
+
 * Board Control and Status (BCSR)
 
 Required properties:
-- 
1.7.4.1
