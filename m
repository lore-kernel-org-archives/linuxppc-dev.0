Return-Path: <roy.pledge@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0043.outbound.protection.outlook.com [104.47.42.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdbhy0WYrzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 06:38:09 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Valentin
 Rothberg <valentinrothberg@gmail.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [v4 06/11] soc/fsl/qbman: Fix ARM32 typo
Date: Thu, 24 Aug 2017 16:37:50 -0400
Message-ID: <1503607075-28970-7-git-send-email-roy.pledge@nxp.com>
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

From: Valentin Rothberg <valentinrothberg@gmail.com>

The Kconfig symbol for 32bit ARM is 'ARM', not 'ARM32'.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index f85c319..81a9a5e 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -53,7 +53,7 @@ static inline void dpaa_flush(void *p)
 {
 #ifdef CONFIG_PPC
 	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
-#elif defined(CONFIG_ARM32)
+#elif defined(CONFIG_ARM)
 	__cpuc_flush_dcache_area(p, 64);
 #elif defined(CONFIG_ARM64)
 	__flush_dcache_area(p, 64);
-- 
2.7.4
