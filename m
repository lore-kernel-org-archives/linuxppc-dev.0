Return-Path: <B29983@freescale.com>
From: <Yuantian.Tang@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCH] clk/mpc85xx: Update the compatible string
Date: Wed, 22 May 2013 16:22:19 +0800
Message-ID: <1369210939-25087-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

The compatible string of clock is changed from *-2 to *-2.0
on chassis 2. So updated it accordingly.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index a2d483f..e958707 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -260,7 +260,7 @@ static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
 
 static const struct of_device_id ppc_clk_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
-	{ .compatible = "fsl,qoriq-clockgen-2", },
+	{ .compatible = "fsl,qoriq-clockgen-2.0", },
 	{}
 };
 
-- 
1.8.0
