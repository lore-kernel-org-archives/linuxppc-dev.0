Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT0B26TtrzDrqF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 18:28:58 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so11030537pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 01:28:58 -0700 (PDT)
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To: olof@lixom.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, mpm@selenic.com
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH] hwrng: pasemi-rng - Use linux/io.h instead of asm/io.h
Date: Tue,  6 Sep 2016 13:58:39 +0530
Message-Id: <1473150519-30931-1-git-send-email-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checkpatch.pl warns about usage of asm/io.h. Use linux/io.h instead.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/char/hw_random/pasemi-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index b4e32f7..545df48 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -26,7 +26,7 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #define SDCRNG_CTL_REG			0x00
 #define   SDCRNG_CTL_FVLD_M		0x0000f000
-- 
2.5.0
