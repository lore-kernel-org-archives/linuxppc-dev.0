Return-Path: <jesper.juhl@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 56624DDE41
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 01:03:28 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so796642ugc
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 08:03:26 -0700 (PDT)
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][09/37] Clean up duplicate includes in drivers/macintosh/
Date: Sat, 21 Jul 2007 17:02:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707211702.30610.jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jesper Juhl <jesper.juhl@gmail.com>, linuxppc-dev@ozlabs.org
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
	drivers/macintosh/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 4177ff0..2c21d4f 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -30,7 +30,6 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
-#include <asm/dbdma.h>
 #include <asm/macio.h>
 #include <asm/keylargo.h>
 
