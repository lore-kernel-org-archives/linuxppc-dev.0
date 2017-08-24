Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0080.outbound.protection.outlook.com [104.47.38.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdbj00wVDzDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 06:38:11 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [v4 10/11] soc/fsl/qbman: Add missing headers on ARM
Date: Thu, 24 Aug 2017 16:37:54 -0400
Message-ID: <1503607075-28970-11-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
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
index 0a1d573..8ec6a78 100644
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
