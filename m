Return-Path: <B35336@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 563A3B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 21:18:49 +1100 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] l2sram: Add compatible entry for mpc8548
Date: Wed, 22 Feb 2012 18:20:13 +0800
Message-ID: <1329906014-9896-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 5f88797..2503cef 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -200,6 +200,9 @@ static struct of_device_id mpc85xx_l2ctlr_of_match[] = {
 	{
 		.compatible = "fsl,p1022-l2-cache-controller",
 	},
+	{
+		.compatible = "fsl,mpc8548-l2-cache-controller",
+	},
 	{},
 };
 
-- 
1.6.4.1
