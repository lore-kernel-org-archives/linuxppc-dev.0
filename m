Return-Path: <geoff@infradead.org>
Message-Id: <c5254081722274cb11fd7d2bc4f3a91b95f0f9f6.1433959045.git.geoff@infradead.org>
In-Reply-To: <cover.1433959045.git.geoff@infradead.org>
References: <cover.1433959045.git.geoff@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] block/ps3vram: Remove obsolete reference to MTD
To: Jens Axboe <axboe@kernel.dk>
Cc: Jim Paris <jim@jtan.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Sender: Geoff Levand <geoff@infradead.org>
Date: Wed, 10 Jun 2015 18:00:17 +0000
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
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/block/ps3vram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index a7bf836..b1612eb 100644
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
2.1.0
