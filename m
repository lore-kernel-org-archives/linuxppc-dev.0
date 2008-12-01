Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF6A5DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 07:54:22 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mB1KsIeG006608
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2008 14:54:18 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: minor head_fsl_booke.S cleanup
Date: Mon,  1 Dec 2008 14:54:18 -0600
Message-Id: <1228164858-7492-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed unused branch labels

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 8942d7a..2b57605 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -751,7 +751,7 @@ finish_tlb_load:
 	iseleq	r12, r12, r10
 	
 #ifdef CONFIG_PTE_64BIT
-2:	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
+	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
 	rlwimi	r12, r11, 24, 8, 19	/* grab RPN[40:51] */
 	mtspr	SPRN_MAS3, r12
 BEGIN_FTR_SECTION
@@ -759,7 +759,7 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_MAS7, r10
 END_FTR_SECTION_IFSET(CPU_FTR_BIG_PHYS)
 #else
-2:	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
+	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
 	mtspr	SPRN_MAS3, r11
 #endif
 #ifdef CONFIG_E200
-- 
1.5.6.5
