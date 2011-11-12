Return-Path: <mylinux@10.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2DC601007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 23:03:06 +1100 (EST)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <Alexandre.Bounine@idt.com>
Subject: [PATCH 4/5,
 v3] powerpc/8xxx: Update device tree bus probe for new RapidIO node
 binding
Date: Sat, 12 Nov 2011 20:02:31 +0800
Message-ID: <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
In-Reply-To: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, Kai Jiang <Kai.Jiang@freescale.com>,
 r61911@freescale.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 B11780@freescale.com
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
1.7.3.1
