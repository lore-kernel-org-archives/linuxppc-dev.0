Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04EE61A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:24 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 5/8] clk: ppc-corenet: Make local symbol 'static'
Date: Tue, 20 Jan 2015 04:09:27 -0600
Message-ID: <1421748570-14282-6-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
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

drivers/clk/clk-ppc-corenet.c:63:22: warning: symbol 'cmux_ops' was not declared. Should it be static?

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 6a9dbaa..d84a7f0 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -57,7 +57,7 @@ static u8 cmux_get_parent(struct clk_hw *hw)
 	return clksel;
 }
 
-const struct clk_ops cmux_ops = {
+static const struct clk_ops cmux_ops = {
 	.get_parent = cmux_get_parent,
 	.set_parent = cmux_set_parent,
 };
-- 
2.2.2
