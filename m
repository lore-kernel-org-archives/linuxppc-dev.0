Return-Path: <hongtao.jia@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0078.outbound.protection.outlook.com [104.47.34.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2xsQ45gQzDvYH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 13:28:26 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
 <scott.wood@nxp.com>, <shawnguo@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <hongtao.jia@nxp.com>
Subject: [PATCH V3 2/2] powerpc/mpc85xx: Update TMU device tree node for
 T1023/T1024
Date: Tue, 25 Oct 2016 10:15:42 +0800
Message-ID: <1477361742-589-2-git-send-email-hongtao.jia@nxp.com>
In-Reply-To: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
References: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
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

Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
sensor specifier added is the monitoring site ID, and represents the "n" in
TRITSRn and TRATSRn.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V3:
* Update the commit log to a better description.

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
