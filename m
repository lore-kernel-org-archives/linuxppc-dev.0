Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0FAC1A09B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:30 +1100 (AEDT)
Received: by ykp131 with SMTP id 131so7175476ykp.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:28 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 7/9] fbdev: remove the unnecessary includes of ppc specific
 header files
Date: Thu, 12 Mar 2015 20:32:48 +0800
Message-Id: <1426163570-10281-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
References: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/core/fbmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 868facdec638..01ef1b953390 100644
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
2.1.0
