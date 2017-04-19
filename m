Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0055.outbound.protection.outlook.com [104.47.38.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7YyG2qSjzDq9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 06:49:10 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Stuart
 Yoder <stuart.yoder@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 11/11] fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM
Date: Wed, 19 Apr 2017 16:48:50 -0400
Message-ID: <1492634930-10765-12-git-send-email-roy.pledge@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
[Stuart: changed to use ARCH_LAYERSCAPE]
Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index 757033c..fb4e6bf 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,6 +1,6 @@
 menuconfig FSL_DPAA
 	bool "Freescale DPAA 1.x support"
-	depends on FSL_SOC_BOOKE
+	depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.7.4
