Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4605D1009BA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 00:01:08 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 2/5] fsl-diu-fb: move fsl-diu-fb.h to include/linux
Date: Fri, 23 Jul 2010 16:00:36 +0200
Message-Id: <1279893639-24333-3-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-1-git-send-email-agust@denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
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
Acked-by: Timur Tabi <timur@freescale.com>
---
v4:
 - added ack tag

v3:
 - no changes since v1

 drivers/video/fsl-diu-fb.c                    |    2 +-
 {drivers/video => include/linux}/fsl-diu-fb.h |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 9b8c991..48905d5 100644
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
1.7.0.4
