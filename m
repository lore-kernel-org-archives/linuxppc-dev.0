Return-Path: <hrai@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 444832C039C
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 20:14:31 +1100 (EST)
Received: from mail19-co1 (localhost [127.0.0.1])	by mail19-co1-R.bigfish.com
 (Postfix) with ESMTP id CF3217C0113	for <linuxppc-dev@ozlabs.org>;
 Tue, 19 Feb 2013 09:14:27 +0000 (UTC)
Received: from CO1EHSMHS004.bigfish.com (unknown [10.243.78.209])	by
 mail19-co1.bigfish.com (Postfix) with ESMTP id B5290680053	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 09:14:25 +0000 (UTC)
From: Harninder Rai <harninder.rai@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] bsc9131:l2sram: Add compatible string for BSC9131 platform
Date: Tue, 19 Feb 2013 14:44:21 +0530
Message-ID: <1361265261-28169-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
---
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 8cf93f0..afc2dbf 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -203,6 +203,7 @@ static struct of_device_id mpc85xx_l2ctlr_of_match[] = {
 	{	.compatible = "fsl,p1024-l2-cache-controller",},
 	{	.compatible = "fsl,p1015-l2-cache-controller",},
 	{	.compatible = "fsl,p1010-l2-cache-controller",},
+	{	.compatible = "fsl,bsc9131-l2-cache-controller",},
 	{},
 };
 
-- 
1.7.6.GIT
