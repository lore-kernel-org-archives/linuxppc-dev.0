Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F7121A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 20:30:23 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] dt/bindings: fsl/guts: Added global-utilities compatibles
Date: Thu, 9 Apr 2015 09:19:52 +0300
Message-ID: <1428560392-30903-1-git-send-email-igal.liberman@freescale.com>
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

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/guts.txt       |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
index 7f150b5..e4f0ac2 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
@@ -9,6 +9,20 @@ Required properties:
 
  - compatible : Should define the compatible device type for
    global-utilities.
+   Possible compatibles:
+	"fsl,qoriq-device-config-1.0"
+	"fsl,p2041-device-config"
+	"fsl,p3041-device-config"
+	"fsl,p4080-device-config"
+	"fsl,p5020-device-config"
+	"fsl,p5040-device-config"
+	"fsl,qoriq-device-config-2.0"
+	"fsl,b4860-device-config"
+	"fsl,b4420-device-config"
+	"fsl,b4-device-config"
+	"fsl,t1040-device-config"
+	"fsl,t2080-device-config"
+	"fsl,t4240-device-config"
  - reg : Offset and length of the register set for the device.
 
 Recommended properties:
-- 
1.7.9.5
