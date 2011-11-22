Return-Path: <B36685@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D3C851007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 20:54:48 +1100 (EST)
Received: from mail27-db3 (localhost [127.0.0.1])	by mail27-db3-R.bigfish.com
 (Postfix) with ESMTP id 791192020E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 22 Nov 2011 09:53:55 +0000 (UTC)
Received: from DB3EHSMHS015.bigfish.com (unknown [10.3.81.253])	by
 mail27-db3.bigfish.com (Postfix) with ESMTP id 5852B2C0043	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 09:53:55 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mtd/nand: Add NAND chip ID to support Micron 4k pagesize NAND
 chip
Date: Tue, 22 Nov 2011 17:23:06 +0800
Message-ID: <1321953786-26472-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add NAND chip ID 0x38 in ids table to support Micron 4k large-page NAND chip.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/mtd/nand/nand_ids.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
index 00cf1b0..23ed1d2 100644
--- a/drivers/mtd/nand/nand_ids.c
+++ b/drivers/mtd/nand/nand_ids.c
@@ -106,6 +106,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 	/* 8 Gigabit */
 	{"NAND 1GiB 1,8V 8-bit",	0xA3, 0, 1024, 0, LP_OPTIONS},
 	{"NAND 1GiB 3,3V 8-bit",	0xD3, 0, 1024, 0, LP_OPTIONS},
+	{"NAND 1GiB 3,3V 8-bit",	0x38, 0, 1024, 0, LP_OPTIONS},
 	{"NAND 1GiB 1,8V 16-bit",	0xB3, 0, 1024, 0, LP_OPTIONS16},
 	{"NAND 1GiB 3,3V 16-bit",	0xC3, 0, 1024, 0, LP_OPTIONS16},
 
-- 
1.6.4
