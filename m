Return-Path: <jun.yang@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0070.outbound.protection.outlook.com [104.47.41.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3kGv0hM8zDt4D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 19:49:42 +1100 (AEDT)
From: jun <jun.yang@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: jun <jun.yang@nxp.com>
Subject: [PATCH] fsl_pamu: erratum a007907 should be applied on all versions
 of E6500 chips.
Date: Thu, 27 Oct 2016 00:50:44 +0800
Message-ID: <1477500644-31812-1-git-send-email-jun.yang@nxp.com>
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

Signed-off-by: jun <jun.yang@nxp.com>
---
 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index db3a1cd..a8fe503 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -668,7 +668,7 @@ static bool has_erratum_a007907(void)
 {
 	u32 pvr = mfspr(SPRN_PVR);
 
-	if (PVR_VER(pvr) == PVR_VER_E6500 && PVR_REV(pvr) <= 0x20)
+	if (PVR_VER(pvr) == PVR_VER_E6500)
 		return true;
 
 	return false;
-- 
2.7.4
