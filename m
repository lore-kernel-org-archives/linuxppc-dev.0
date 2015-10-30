Return-Path: <raghav@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0108.outbound.protection.outlook.com [65.55.169.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7EAF1A0BFA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:57:18 +1100 (AEDT)
From: Raghav Dogra <raghav@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <prabhakar@freescale.com>, Raghav Dogra
 <raghav@freescale.com>
Subject: [PATCH 2/2] powerpc/fsl_lbc: removal of dead code
Date: Fri, 30 Oct 2015 11:52:02 +0530
Message-ID: <1446186122-2870-1-git-send-email-raghav@freescale.com>
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

The condition check is not used.

Signed-off-by: Raghav Dogra <raghav@freescale.com>
---
 arch/powerpc/sysdev/fsl_lbc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 332d700..a41d281 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -244,8 +244,6 @@ static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
 	if (status & LTESR_CS)
 		dev_err(ctrl->dev, "Chip select error: "
 			"LTESR 0x%08X\n", status);
-	if (status & LTESR_UPM)
-		;
 	if (status & LTESR_FCT) {
 		dev_err(ctrl->dev, "FCM command time-out: "
 			"LTESR 0x%08X\n", status);
-- 
1.9.1
