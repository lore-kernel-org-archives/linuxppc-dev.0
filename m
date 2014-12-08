Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9797A1A0A0C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:40:31 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0135.outbound.protection.outlook.com [157.56.111.135])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A6D991400E9
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 21:40:30 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/6] dt/bindings: b/qman: Fix the alloc-ranges in the
 example(s)
Date: Mon, 8 Dec 2014 04:29:16 -0600
Message-ID: <1418034561-12034-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1418034561-12034-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1418034561-12034-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'ranges' are specified as <base size> not as <start end>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 2 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt b/Documentation/devicetree/bindings/soc/fsl/bman.txt
index 9f80bf8..ee03ef2 100644
--- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
@@ -96,7 +96,7 @@ The example below shows a BMan FBPR dynamic allocation memory node
 
 		bman_fbpr: bman-fbpr {
 			compatible = "fsl,bman-fbpr";
-			alloc-ranges = <0 0 0xf 0xffffffff>;
+			alloc-ranges = <0 0 0x10 0>;
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
 		};
diff --git a/Documentation/devicetree/bindings/soc/fsl/qman.txt b/Documentation/devicetree/bindings/soc/fsl/qman.txt
index 063e3a0..f3da91e 100644
--- a/Documentation/devicetree/bindings/soc/fsl/qman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/qman.txt
@@ -113,13 +113,13 @@ The example below shows a QMan FQD and a PFDR dynamic allocation memory nodes
 
 		qman_fqd: qman-fqd {
 			compatible = "fsl,qman-fqd";
-			alloc-ranges = <0 0 0xf 0xffffffff>;
+			alloc-ranges = <0 0 0x10 0>;
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
 		};
 		qman_pfdr: qman-pfdr {
 			compatible = "fsl,qman-pfdr";
-			alloc-ranges = <0 0 0xf 0xffffffff>;
+			alloc-ranges = <0 0 0x10 0>;
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
 		};
-- 
2.2.0
