Return-Path: <Shruti@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 148E91A03E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 06:31:54 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH v2 2/7] net/fsl_pq_mdio: Document supported compatibles
Date: Wed, 16 Jul 2014 15:17:06 -0500
Message-ID: <1405541831-1277-2-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device tree binding(s) document has fallen out of sync with the
driver code. Update the list of supported devices to reflect current
driver capabilities

Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 Documentation/devicetree/bindings/net/fsl-tsec-phy.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index be6ea89..1e97532 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -8,7 +8,16 @@ of how to define a PHY.
 Required properties:
   - reg : Offset and length of the register set for the device
   - compatible : Should define the compatible device type for the
-    mdio.  Currently, this is most likely to be "fsl,gianfar-mdio"
+    mdio. Currently supported strings/devices are:
+	- "fsl,gianfar-tbi"
+	- "fsl,gianfar-mdio"
+	- "fsl,etsec2-tbi"
+	- "fsl,etsec2-mdio"
+	- "fsl,ucc-mdio"
+	- "fsl,fman-mdio"
+    When device_type is "mdio", the following strings are also considered:
+	- "gianfar"
+	- "ucc_geth_phy"
 
 Example:
 
-- 
1.8.3.1
