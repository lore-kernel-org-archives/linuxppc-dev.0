Return-Path: <B44306@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 886D32C02A9
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 02:17:28 +1000 (EST)
Received: from mail220-ch1 (localhost [127.0.0.1])	by
 mail220-ch1-R.bigfish.com (Postfix) with ESMTP id 39DA7180263	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 16:17:25 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail220-ch1.bigfish.com (Postfix) with ESMTP id
 99BA0E006D
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 16:17:23 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/perf: correct typos in counter enumeration
Date: Wed, 5 Jun 2013 11:17:17 -0500
Message-ID: <1370449040-12970-1-git-send-email-Lijun.Pan@freescale.com>
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
