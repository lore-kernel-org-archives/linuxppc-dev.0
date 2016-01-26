Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m2.elettra.trieste.it [140.105.206.202])
 by lists.ozlabs.org (Postfix) with ESMTP id CE0161A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 23:25:38 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: powerpc/dts: Move mvme2500.dts back in the right place
Date: Tue, 26 Jan 2016 13:25:27 +0100
Message-Id: <1453811127-28591-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit dc37374b9c83 ("powerpc/fsl: Move Freescale device tree files into
fsl folder") move also mvme2500.dts which isn't a device tree for a
Freescale board but for an Artesyn one. So move mvme2500.dts back in the
right place.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/{fsl => }/mvme2500.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/boot/dts/{fsl => }/mvme2500.dts (98%)

diff --git a/arch/powerpc/boot/dts/fsl/mvme2500.dts b/arch/powerpc/boot/dts/mvme2500.dts
similarity index 98%
rename from arch/powerpc/boot/dts/fsl/mvme2500.dts
rename to arch/powerpc/boot/dts/mvme2500.dts
index c7bc1a0..67714cf 100644
--- a/arch/powerpc/boot/dts/fsl/mvme2500.dts
+++ b/arch/powerpc/boot/dts/mvme2500.dts
@@ -12,7 +12,7 @@
  * Copyright 2009 Freescale Semiconductor Inc.
  */
 
-/include/ "p2020si-pre.dtsi"
+/include/ "fsl/p2020si-pre.dtsi"
 
 / {
 	model = "MVME2500";
@@ -258,7 +258,7 @@
 	};
 };
 
-/include/ "p2020si-post.dtsi"
+/include/ "fsl/p2020si-post.dtsi"
 
 / {
 	soc@ffe00000 {
-- 
2.7.0
