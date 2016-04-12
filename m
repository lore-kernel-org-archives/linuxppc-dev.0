Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkbGF5sXvzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 15:34:13 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id td3so6744676pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:34:13 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Remove unused remnants from A2 cpu
Date: Tue, 12 Apr 2016 15:33:58 +1000
Message-Id: <1460439238-13428-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for the A2 cpu was removed in commit fb5a515704d7 ("powerpc:
Remove platforms/wsp and associated pieces"), and the externs:
__setup_cpu_a2 and __restore_cpu_a2 are still around and unused, so
remove them.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/cputable.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c662b8de90d..eeeacf6235a3 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -63,7 +63,6 @@ extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_a2(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
 extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
@@ -72,7 +71,6 @@ extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power9(void);
-extern void __restore_cpu_a2(void);
 extern void __flush_tlb_power7(unsigned int action);
 extern void __flush_tlb_power8(unsigned int action);
 extern void __flush_tlb_power9(unsigned int action);
-- 
2.5.0
