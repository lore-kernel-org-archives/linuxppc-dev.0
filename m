Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0053.outbound.protection.outlook.com [104.47.36.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGyJS3pMCzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 07:30:32 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, <roy.pledge@nxp.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>
Subject: [PATCH v3 10/11] soc/fsl/qbman: Add missing headers on ARM
Date: Mon, 1 May 2017 17:30:12 -0400
Message-ID: <1493674213-963-11-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Unlike PPC builds, ARM builds need following headers
explicitly:
+#include <linux/io.h>		for ioread32be()
+#include <linux/delay.h>		for udelay()

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 81a9a5e..9925013 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -44,6 +44,8 @@
 #include <linux/prefetch.h>
 #include <linux/genalloc.h>
 #include <asm/cacheflush.h>
+#include <linux/io.h>
+#include <linux/delay.h>
 
 /* For 2-element tables related to cache-inhibited and cache-enabled mappings */
 #define DPAA_PORTAL_CE 0
-- 
2.7.4
