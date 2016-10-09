Return-Path: <hongtao.jia@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0070.outbound.protection.outlook.com [104.47.37.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssDdg46f4zDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 17:59:33 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
 <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <hongtao.jia@nxp.com>
Subject: [PATCH V2 2/5] powerpc/mpc85xx: Update TMU device tree node for
 T1023/T1024
Date: Sun, 9 Oct 2016 14:47:03 +0800
Message-ID: <1475995626-14049-2-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
References: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongtao Jia <hongtao.jia@nxp.com>

SoC compatible string and endianness property are added according to the
new bindings.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V2:
* Rebase on latest linux-next tree (next-20161006).

 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 6e0b489..bce762a 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -321,7 +321,7 @@
 				       0x00030001 0x0000000d
 				       0x00030002 0x00000019
 				       0x00030003 0x00000024>;
-		#thermal-sensor-cells = <0>;
+		#thermal-sensor-cells = <1>;
 	};
 
 	thermal-zones {
@@ -329,7 +329,7 @@
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 
-			thermal-sensors = <&tmu>;
+			thermal-sensors = <&tmu 0>;
 
 			trips {
 				cpu_alert: cpu-alert {
-- 
2.1.0.27.g96db324
