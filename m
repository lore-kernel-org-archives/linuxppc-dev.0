Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99A29B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 21:22:35 +1000 (EST)
Received: from mail117-ch1 (localhost.localdomain [127.0.0.1])	by
	mail117-ch1-R.bigfish.com (Postfix) with ESMTP id 670A99A0309	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 11:22:28 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.254])	by mail117-ch1.bigfish.com (Postfix) with ESMTP id
	452246E8053	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 11:22:28 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/85xx: enable pcie initialization for P4080
Date: Thu, 21 Jul 2011 18:25:14 +0800
Message-ID: <1311243914-4349-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 2ab338c..15247b0 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -114,6 +114,9 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 		.compatible	= "simple-bus"
 	},
 	{
+		.compatible	= "fsl,p4080-pcie"
+	},
+	{
 		.compatible	= "fsl,rapidio-delta",
 	},
 	{}
-- 
1.6.4
