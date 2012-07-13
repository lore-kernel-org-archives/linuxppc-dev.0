Return-Path: <B29983@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA1742C02BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 12:49:06 +1000 (EST)
Received: from mail120-am1 (localhost [127.0.0.1])	by
 mail120-am1-R.bigfish.com (Postfix) with ESMTP id D05C042025E	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 02:49:00 +0000 (UTC)
Received: from AM1EHSMHS017.bigfish.com (unknown [10.3.201.241])	by
 mail120-am1.bigfish.com (Postfix) with ESMTP id ED6B86025F	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 02:48:58 +0000 (UTC)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: L2sram: Add compatible string to the device id
 list
Date: Fri, 13 Jul 2012 10:27:34 +0800
Message-ID: <1342146455-27729-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

The following platforms are supported:
mpc8544, mpc8572, mpc8536, p1021, p1025, p1024, p1010.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index cedabd0..611bb4b 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -204,6 +204,16 @@ static struct of_device_id mpc85xx_l2ctlr_of_match[] = {
 	{
 		.compatible = "fsl,mpc8548-l2-cache-controller",
 	},
+	{	.compatible = "fsl,mpc8544-l2-cache-controller",},
+	{	.compatible = "fsl,mpc8572-l2-cache-controller",},
+	{	.compatible = "fsl,mpc8536-l2-cache-controller",},
+	{	.compatible = "fsl,p1021-l2-cache-controller",},
+	{	.compatible = "fsl,p1012-l2-cache-controller",},
+	{	.compatible = "fsl,p1025-l2-cache-controller",},
+	{	.compatible = "fsl,p1016-l2-cache-controller",},
+	{	.compatible = "fsl,p1024-l2-cache-controller",},
+	{	.compatible = "fsl,p1015-l2-cache-controller",},
+	{	.compatible = "fsl,p1010-l2-cache-controller",},
 	{},
 };
 
-- 
1.6.4
