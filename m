Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BE751A0D28
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 09:02:55 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v3] net/fsl_pq_mdio: Document supported compatibles
Date: Sun, 1 Feb 2015 15:58:31 -0600
Message-ID: <1422827911-32629-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>,
 Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>

The device tree binding(s) document has fallen out of sync with the
driver code. Update the list of supported devices to reflect current
driver capabilities

Change-Id: I440d8de2ee2d9c3b7b23e69b3da851cab18a4c9a
Signed-off-by: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

v3:	Separated from the FMan MDIO dt/binding patchset http://patchwork.ozlabs.org/patch/370870

 Documentation/devicetree/bindings/net/fsl-tsec-phy.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index be6ea896..1e97532 100644
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
2.2.2
