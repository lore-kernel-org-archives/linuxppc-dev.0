Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AC05B6FFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:04:59 +1100 (EST)
Received: from mail61-am1 (localhost [127.0.0.1])	by mail61-am1-R.bigfish.com
 (Postfix) with ESMTP id 00DB3360140	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:04:54 +0000 (UTC)
Received: from AM1EHSMHS014.bigfish.com (unknown [10.3.201.235])	by
 mail61-am1.bigfish.com (Postfix) with ESMTP id E9BBF3E0052	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:51 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/9] l2sram: Add compatible entry for mpc8548
Date: Tue, 6 Mar 2012 17:06:39 +0800
Message-ID: <1331024805-15926-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
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
