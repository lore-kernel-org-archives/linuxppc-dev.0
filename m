Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39ACC1400E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 22:53:07 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH 2/2] ARM: dts: Add ipg clock for sai2 on VF610 platform
Date: Tue, 1 Apr 2014 19:52:53 +0800
Message-ID: <0c5ca85a8d6ab2e8ee5e543d7ab8ec4c2ff5bf2a.1396352401.git.Guangyu.Chen@freescale.com>
In-Reply-To: <cover.1396352401.git.Guangyu.Chen@freescale.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we added ipg clock to the DT binding, we should update the current
SAI dts/dtsi so as not to break their functions.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index d31ce1b..493c498 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -140,6 +140,6 @@
 				reg = <0x40031000 0x1000>;
 				interrupts = <0 86 0x04>;
-				clocks = <&clks VF610_CLK_SAI2>;
-				clock-names = "sai";
+				clocks = <&clks VF610_CLK_SAI2>, <&clks VF610_CLK_SAI2>;
+				clock-names = "ipg", "sai";
 				status = "disabled";
 			};
-- 
1.8.4
