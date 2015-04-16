Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B33A1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 01:49:59 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [v3] dt/bindings: fsl/guts: Added global-utilities compatibles
Date: Thu, 16 Apr 2015 14:41:11 +0300
Message-ID: <1429184471-6801-1-git-send-email-igal.liberman@freescale.com>
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

v3 - Addressed Scott's feedback:
	Added "fsl,<chip>-guts"

v2 - Addressed Scott's feedback

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/guts.txt       |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
index 7f150b5..b71b203 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
@@ -9,6 +9,11 @@ Required properties:
 
  - compatible : Should define the compatible device type for
    global-utilities.
+   Possible compatibles:
+	"fsl,qoriq-device-config-1.0"
+	"fsl,qoriq-device-config-2.0"
+	"fsl,<chip>-device-config"
+	"fsl,<chip>-guts"
  - reg : Offset and length of the register set for the device.
 
 Recommended properties:
-- 
1.7.9.5
