Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B4E70B7D48
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 09:49:37 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] fsl-diu-fb: move fsl-diu-fb.h to include/linux
Date: Fri, 30 Apr 2010 01:49:35 +0200
Message-Id: <1272584978-19063-3-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some DIU structures will be used in platform code in
subsequent MPC5121 DIU patch, so we move this header
to be able to include it elsewhere.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/fsl-diu-fb.c                    |    2 +-
 {drivers/video => include/linux}/fsl-diu-fb.h |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index ee15a99..7acdc09 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -34,7 +34,7 @@
 #include <linux/of_platform.h>
 
 #include <sysdev/fsl_soc.h>
-#include "fsl-diu-fb.h"
+#include <linux/fsl-diu-fb.h>
 
 /*
  * These parameters give default parameters
diff --git a/drivers/video/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
similarity index 100%
rename from drivers/video/fsl-diu-fb.h
rename to include/linux/fsl-diu-fb.h
-- 
1.6.3.3
