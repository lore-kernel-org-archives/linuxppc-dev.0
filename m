Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD983B7280
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 01:11:02 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5][v2] powerpc/8xxx: Update device tree bus probe for new
 RapidIO node binding
Date: Thu, 13 Oct 2011 09:08:42 -0500
Message-Id: <1318514922-12672-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1318514922-12672-4-git-send-email-galak@kernel.crashing.org>
References: <1318514922-12672-1-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-2-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-3-git-send-email-galak@kernel.crashing.org>
 <1318514922-12672-4-git-send-email-galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, alexandre.bounine@idt.com,
 Kai Jiang <Kai.Jiang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kai Jiang <Kai.Jiang@freescale.com>

Update of_platform_bus_probe() RapidIO node to be compitable with
new RapidIO dts compatible property.

Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 802ad11..c48b661 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -112,7 +112,7 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 		.compatible	= "simple-bus"
 	},
 	{
-		.compatible	= "fsl,rapidio-delta",
+		.compatible	= "fsl,srio",
 	},
 	{
 		.compatible	= "fsl,p4080-pcie",
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a23a3ff..7968ced 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -433,7 +433,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
-	{ .compatible = "fsl,rapidio-delta", },
+	{ .compatible = "fsl,srio", },
 	{ .compatible = "fsl,mpc8548-guts", },
 	{ .compatible = "gpio-leds", },
 	{},
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index b11c353..569262c 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -161,7 +161,7 @@ mpc86xx_time_init(void)
 
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
-	{ .compatible = "fsl,rapidio-delta", },
+	{ .compatible = "fsl,srio", },
 	{ .compatible = "gianfar", },
 	{},
 };
-- 
1.7.3.4
