Return-Path: <jesper.juhl@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 52EA0DDEB7
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 01:05:05 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so796800ugc
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 08:05:03 -0700 (PDT)
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][36/37] Clean up duplicate includes in sound/ppc/
Date: Sat, 21 Jul 2007 17:04:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707211704.07263.jesper.juhl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Jesper Juhl <jesper.juhl@gmail.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch cleans up duplicate includes in
	XXXX/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 1aa0b46..27b6189 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -33,7 +33,6 @@
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
 #include <asm/firmware.h>
-#include <linux/io.h>
 #include <asm/dma.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
