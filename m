Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0102.outbound.protection.outlook.com [65.55.169.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7DE11A090C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 22:51:40 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: Add FMan best effort port compatible
Date: Mon, 18 May 2015 11:41:59 +0300
Message-ID: <1431938519-11343-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <igal.liberman@freescale.com>,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <igal.liberman@freescale.com>

This patch adds a compatible which represents FMan V3 best effort ports.
FMan best effort port is configured as 10G ports, however, it uses 1G
hardware.

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/fman.txt       |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index edda55f..c2e3ec3 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -166,6 +166,11 @@ PROPERTIES
 			- "fsl,fman-v3-port-oh" for FManV3 OH ports
 			- "fsl,fman-v3-port-rx" for FManV3 RX ports
 			- "fsl,fman-v3-port-tx" for FManV3 TX ports
+		Optional compatible which can be used in addition to the
+		compatibles above is:
+			- "fsl,fman-v3-best-effort-port"
+		This compatible represents 10G best effort ports:
+			Port configured as 10G, using 1G hardware.
 
 - cell-index
 		Usage: required
-- 
1.7.9.5
