Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD0181A0840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 20:53:33 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/2] mtd/spi: support en25s64 device
Date: Wed, 21 May 2014 18:05:50 +0800
Message-ID: <1400666751-11459-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for EON en25s64 spi device.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/mtd/devices/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7eda71d..6989311 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -745,6 +745,7 @@ static const struct spi_device_id m25p_ids[] = {
 	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
 	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
 	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
+	{ "en25s64",    INFO(0x1c3817, 0, 64 * 1024,  128, 0) },
 	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
 
 	/* ESMT */
-- 
1.8.0
