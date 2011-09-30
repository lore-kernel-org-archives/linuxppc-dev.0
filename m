Return-Path: <B21989@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2F2F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 18:19:20 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mtd: m25p80: add EON flash EN25Q32B into spi flash id table
Date: Fri, 30 Sep 2011 15:08:38 +0800
Message-ID: <1317366518-11403-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mtd@lists.infradead.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for EON spi flash EN25Q32B, which is not listed in id table,
need to add it in the id table to support the EON flash.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/mtd/devices/m25p80.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 35180e4..4e20c4d 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -671,6 +671,7 @@ static const struct spi_device_id m25p_ids[] = {
 	/* EON -- en25xxx */
 	{ "en25f32", INFO(0x1c3116, 0, 64 * 1024,  64, SECT_4K) },
 	{ "en25p32", INFO(0x1c2016, 0, 64 * 1024,  64, 0) },
+	{ "en25q32b", INFO(0x1c3016, 0, 64 * 1024,  64, 0) },
 	{ "en25p64", INFO(0x1c2017, 0, 64 * 1024, 128, 0) },
 
 	/* Intel/Numonyx -- xxxs33b */
-- 
1.6.4
