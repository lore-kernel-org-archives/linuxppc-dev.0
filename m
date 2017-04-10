Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w252919tTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:48:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Remove unnecessary includes of asm/debug.h
Date: Tue, 11 Apr 2017 08:48:27 +1000
Message-Id: <1491864507-16741-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1491864507-16741-1-git-send-email-mpe@ellerman.id.au>
References: <1491864507-16741-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These files don't seem to have any need for asm/debug.h, now that all it
includes are the debugger hooks and breakpoint definitions.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/fadump.c         | 1 -
 arch/powerpc/kernel/irq.c            | 1 -
 arch/powerpc/kernel/prom.c           | 1 -
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index c7acc6651ce7..243dbef7e926 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -40,7 +40,6 @@
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/fadump.h>
-#include <asm/debug.h>
 #include <asm/setup.h>
 
 static struct fw_dump fw_dump;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5cae899..097f2f9ff85d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -65,7 +65,6 @@
 #include <asm/machdep.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
-#include <asm/debug.h>
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e46193..d2f0afeae5a0 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -55,7 +55,6 @@
 #include <asm/kexec.h>
 #include <asm/opal.h>
 #include <asm/fadump.h>
-#include <asm/debug.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index e78542d99cd6..d9e312f253fa 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -16,7 +16,6 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
 #include <asm/xics.h>
-#include <asm/debug.h>
 #include <asm/synch.h>
 #include <asm/cputhreads.h>
 #include <asm/pgtable.h>
-- 
2.7.4
