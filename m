Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com
 [IPv6:2607:f8b0:4002:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 819E41A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:44 +1100 (AEDT)
Received: by yhaf10 with SMTP id f10so4195477yha.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:42 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 07/11] fbdev: remove the unnecessary includes of ppc
 specific header files
Date: Thu, 26 Feb 2015 20:08:19 +0800
Message-Id: <1424952503-8247-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current kernel, we don't need to include these arch specific
header files for ppc.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 drivers/video/fbdev/core/fbmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 95338593ebf4..3ae868c58cef 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -33,10 +33,6 @@
 #include <video/edid.h>
 #include <video/of_videomode.h>
 #include <video/videomode.h>
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif
 #include "../edid.h"
 
 /*
-- 
1.9.3
