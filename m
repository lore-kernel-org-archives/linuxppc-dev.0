Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D0A81A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 15:50:53 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
CC: <linux-clk@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH] clk: qoriq: Fix wrong data in p2041_cmux_grp2
Date: Thu, 22 Oct 2015 23:50:34 -0500
Message-ID: <1445575834-30146-1-git-send-email-scottwood@freescale.com>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This is on top of http://patchwork.ozlabs.org/patch/519801/
and I'll apply them together.

 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 8f9c93b..07985a5 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -128,8 +128,8 @@ static const struct clockgen_muxinfo p2041_cmux_grp1 = {
 static const struct clockgen_muxinfo p2041_cmux_grp2 = {
 	{
 		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
-		[4] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
-		[5] = { CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		[4] = { CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		[5] = { CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
 	}
 };
 
-- 
2.1.4
