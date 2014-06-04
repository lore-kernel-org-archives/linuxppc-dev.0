Return-Path: <prvs=023292b902=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DED2C1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 01:40:04 +1000 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc/mpc85xx: fix fsl/p2041-post.dtsi clockgen mux2
Date: Wed,  4 Jun 2014 17:34:01 +0200
Message-Id: <1401896041-22734-1-git-send-email-valentin.longchamp@keymile.com>
Cc: Linux device trees <devicetree@vger.kernel.org>,
 Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mux2 node is missing the clock-output-names field that is required
by the clk-ppc-corenet driver.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---

 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index e2987a3..45ce43c 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -358,6 +358,7 @@
 			compatible = "fsl,qoriq-core-mux-1.0";
 			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
 			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux2";
 		};
 
 		mux3: mux3@60 {
-- 
1.8.0.1
