Return-Path: <Shruti@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CCB0F1400EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 22:21:50 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH 3/6] net/fsl_pq_mdio: Document supported compatibles
Date: Fri, 18 Apr 2014 07:21:30 -0500
Message-ID: <1397823693-27977-3-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Shruti@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org
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
index d2ea460..14b72fc 100644
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
