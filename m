Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F362100820
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:07:18 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAG7Eis027679
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:07:15 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/11] powerpc/85xx: Update P1020 SEC3.3 node to match actual
 SoC HW
Date: Thu, 10 Nov 2011 10:07:03 -0600
Message-Id: <1320941229-29557-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
References: <1320941229-29557-1-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-2-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020si.dtsi |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 25e10cf..5514e1d 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -305,15 +305,16 @@
 		};
 
 		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+				     "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <45 2 58 2>;
 			interrupt-parent = <&mpic>;
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xbfe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			fsl,exec-units-mask = <0x97c>;
+			fsl,descriptor-types-mask = <0x3a30abf>;
 		};
 
 		mpic: pic@40000 {
-- 
1.7.3.4
