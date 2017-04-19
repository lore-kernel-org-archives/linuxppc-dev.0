Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0049.outbound.protection.outlook.com [104.47.38.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7YyB4LWJzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 06:49:06 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Roy
 Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
Date: Wed, 19 Apr 2017 16:48:44 -0400
Message-ID: <1492634930-10765-6-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
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

Not relevant and arch dependent. Overkill for PPC.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 2ce394a..f85c319 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -49,10 +49,6 @@
 #define DPAA_PORTAL_CE 0
 #define DPAA_PORTAL_CI 1
 
-#if (L1_CACHE_BYTES != 32) && (L1_CACHE_BYTES != 64)
-#error "Unsupported Cacheline Size"
-#endif
-
 static inline void dpaa_flush(void *p)
 {
 #ifdef CONFIG_PPC
-- 
2.7.4
