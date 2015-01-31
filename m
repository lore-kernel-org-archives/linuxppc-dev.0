Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AE511A1123
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:42 +1100 (AEDT)
Received: by mail-yk0-f170.google.com with SMTP id q9so19123665ykb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:40 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 08/15] fbdev: remove the unnecessary includes of ppc specific
 header files
Date: Sat, 31 Jan 2015 21:47:38 +0800
Message-Id: <1422712065-9403-9-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
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
