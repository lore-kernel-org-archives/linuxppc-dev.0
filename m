Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 758D12C00AC
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 06:10:52 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2IJAlJJ027877
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Mar 2013 14:10:48 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Update T4240 device config node in device
Date: Mon, 18 Mar 2013 14:10:47 -0500
Message-Id: <1363633847-3725-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As the T4240 is based on corenet chassis v2.0 spec we update the global
utilities (GUTS) device config compatiable to reflect this.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 2b17699..1d72926 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -357,7 +357,7 @@
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,t4240-device-config";
+		compatible = "fsl,t4240-device-config", "fsl,qoriq-device-config-2.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
-- 
1.7.9.7
