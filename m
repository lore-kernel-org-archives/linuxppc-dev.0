Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r05TY3R7gzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 15:00:49 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 May 2016 14:50:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B63AA2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:50:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444oKSo65863914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:50:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444nrMV021380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:49:53 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Remove duplicate #defines
Date: Wed,  4 May 2016 14:48:32 +1000
Message-Id: <1462337312-14010-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

These defines are not used, but other equivalent definitions
(CXL_SPA_SW_CMD_*) are used. Remove the unused defines.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index dfdbfb0..2823fb3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -178,15 +178,6 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_SR_An_MP  (1ull << (63-62)) /* Master Process */
 #define CXL_PSL_SR_An_LE  (1ull << (63-63)) /* Little Endian */
 
-/****** CXL_PSL_LLCMD_An ****************************************************/
-#define CXL_LLCMD_TERMINATE   0x0001000000000000ULL
-#define CXL_LLCMD_REMOVE      0x0002000000000000ULL
-#define CXL_LLCMD_SUSPEND     0x0003000000000000ULL
-#define CXL_LLCMD_RESUME      0x0004000000000000ULL
-#define CXL_LLCMD_ADD         0x0005000000000000ULL
-#define CXL_LLCMD_UPDATE      0x0006000000000000ULL
-#define CXL_LLCMD_HANDLE_MASK 0x000000000000ffffULL
-
 /****** CXL_PSL_ID_An ****************************************************/
 #define CXL_PSL_ID_An_F	(1ull << (63-31))
 #define CXL_PSL_ID_An_L	(1ull << (63-30))
-- 
2.1.4
