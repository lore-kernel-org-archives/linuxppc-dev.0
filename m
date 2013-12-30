Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id 48C382C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 20:07:49 +1100 (EST)
Received: from juliette.telenet-ops.be (juliette.telenet-ops.be
 [195.130.137.74])
 by winston.telenet-ops.be (Postfix) with ESMTP id 1702F1BD61C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 10:07:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geoff Levand <geoff@infradead.org>,
	Jim Paris <jim@jtan.com>
Subject: [PATCH] block/ps3: Remove obsolete reference to MTD
Date: Mon, 30 Dec 2013 10:07:43 +0100
Message-Id: <1388394463-25798-1-git-send-email-geert@linux-m68k.org>
Cc: cbe-oss-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ps3vram driver is a plain block device driver since commit
f507cd22035fdadd5dbb476dd05e9e7ee21c3b84 ("ps3/block: Replace mtd/ps3vram
by block/ps3vram").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/ps3vram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 06a2e53e5f37..313ee641ea10 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -1,5 +1,5 @@
 /*
- * ps3vram - Use extra PS3 video ram as MTD block device.
+ * ps3vram - Use extra PS3 video ram as block device.
  *
  * Copyright 2009 Sony Corporation
  *
-- 
1.7.9.5
