Return-Path: <r66093@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FA35B7020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 11:57:39 +1000 (EST)
Received: from mail83-va3 (localhost [127.0.0.1])	by mail83-va3-R.bigfish.com
 (Postfix) with ESMTP id 4369C2400B1	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 17 Apr 2012 01:57:33 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.249])	by
 mail83-va3.bigfish.com (Postfix) with ESMTP id EFECDE00CB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 01:57:30 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/mpc85xx: p1022ds support the MTD for NOR and NAND
 flash
Date: Tue, 17 Apr 2012 09:42:34 +0800
Message-ID: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The compatilbe 'simple-bus' is removed from the latest DTS for NAND and
NOR flash partition, so we must add the new compatilbe support for p1022ds,
otherwise, the kernel can't parse the partition of NOR and NAND flash.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6c8ff8b..8948293 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -379,6 +379,7 @@ static struct of_device_id __initdata p1022_ds_ids[] = {
 	{ .compatible = "gianfar", },
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
+	{ .compatible = "fsl,p1022-elbc", },
 	{},
 };
 
-- 
1.7.5.4
