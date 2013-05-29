Return-Path: <B44306@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2977B2C00B1
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 08:12:48 +1000 (EST)
Received: from mail169-tx2 (localhost [127.0.0.1])	by
 mail169-tx2-R.bigfish.com (Postfix) with ESMTP id 480C1400BB	for
 <linuxppc-dev@ozlabs.org>; Wed, 29 May 2013 22:12:46 +0000 (UTC)
Received: from TX2EHSMHS015.bigfish.com (unknown [10.9.14.240])	by
 mail169-tx2.bigfish.com (Postfix) with ESMTP id 52BB21E004B	for
 <linuxppc-dev@ozlabs.org>; Wed, 29 May 2013 22:12:44 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/perf: correct typos in counter enumeration
Date: Wed, 29 May 2013 17:12:40 -0500
Message-ID: <1369865562-29525-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun.Pan@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/include/asm/reg_fsl_emb.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index 77bb71c..1cf8ab0 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -17,8 +17,8 @@
 /* Freescale Book E Performance Monitor APU Registers */
 #define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
 #define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
-#define PMRN_PMC2	0x012	/* Performance Monitor Counter 1 */
-#define PMRN_PMC3	0x013	/* Performance Monitor Counter 1 */
+#define PMRN_PMC2	0x012	/* Performance Monitor Counter 2 */
+#define PMRN_PMC3	0x013	/* Performance Monitor Counter 3 */
 #define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
 #define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
 #define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
@@ -55,8 +55,8 @@
 
 #define PMRN_UPMC0	0x000	/* User Performance Monitor Counter 0 */
 #define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
-#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 1 */
-#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 2 */
+#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 3 */
 #define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
 #define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
 #define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
-- 
1.7.9.7
