Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95E81A04C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:11 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 4/6] powerpc: Remove unused 32bit symbol exports
Date: Wed, 20 Aug 2014 08:00:03 +1000
Message-Id: <1408485605-10490-4-git-send-email-anton@samba.org>
In-Reply-To: <1408485605-10490-1-git-send-email-anton@samba.org>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ppc_ksyms.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 4a42a1f..ab4f0bc 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -45,26 +45,10 @@
 #include <asm/epapr_hcalls.h>
 
 #ifdef CONFIG_PPC32
-extern void transfer_to_handler(void);
-extern void do_IRQ(struct pt_regs *regs);
-extern void machine_check_exception(struct pt_regs *regs);
-extern void alignment_exception(struct pt_regs *regs);
-extern void program_check_exception(struct pt_regs *regs);
-extern void single_step_exception(struct pt_regs *regs);
-extern int sys_sigreturn(struct pt_regs *regs);
-
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-
-EXPORT_SYMBOL(transfer_to_handler);
-EXPORT_SYMBOL(do_IRQ);
-EXPORT_SYMBOL(machine_check_exception);
-EXPORT_SYMBOL(alignment_exception);
-EXPORT_SYMBOL(program_check_exception);
-EXPORT_SYMBOL(single_step_exception);
-EXPORT_SYMBOL(sys_sigreturn);
 #endif
 
 #ifdef CONFIG_FUNCTION_TRACER
-- 
1.9.1
