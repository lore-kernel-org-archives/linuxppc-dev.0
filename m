Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqPVF5pwVzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:31:17 +1000 (AEST)
From: Stephen Boyd <sboyd@codeaurora.org>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gerhard Sittig <gsi@denx.de>
Subject: [PATCH] powerpc/512x: clk: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:31:12 -0700
Message-Id: <1461115872-31722-1-git-send-email-sboyd@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Gerhard Sittig <gsi@denx.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index c50ea76ba66c..6081fbd75330 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -221,7 +221,7 @@ static bool soc_has_mclk_mux0_canin(void)
 /* convenience wrappers around the common clk API */
 static inline struct clk *mpc512x_clk_fixed(const char *name, int rate)
 {
-	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
+	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
 static inline struct clk *mpc512x_clk_factor(
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
