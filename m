Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 804E31A0611
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 09:18:33 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/e500mc: Fix wrong value of MCSR_L2MMU_MHIT
Date: Thu, 29 May 2014 18:17:51 -0500
Message-ID: <1401405471-28118-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Ed Swarthout <ed.swarthout@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 163c3b0..4155120 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -260,7 +260,7 @@
 
 /* e500mc */
 #define MCSR_DCPERR_MC	0x20000000UL /* D-Cache Parity Error */
-#define MCSR_L2MMU_MHIT	0x04000000UL /* Hit on multiple TLB entries */
+#define MCSR_L2MMU_MHIT	0x08000000UL /* Hit on multiple TLB entries */
 #define MCSR_NMI	0x00100000UL /* Non-Maskable Interrupt */
 #define MCSR_MAV	0x00080000UL /* MCAR address valid */
 #define MCSR_MEA	0x00040000UL /* MCAR is effective address */
-- 
1.9.1
