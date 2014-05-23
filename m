Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id 28B7C1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 19:07:07 +1000 (EST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
 by winston.telenet-ops.be (Postfix) with ESMTP id 996445908CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:54:44 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] powerpc: Update comments for generic idle conversion
Date: Fri, 23 May 2014 10:54:24 +0200
Message-Id: <1400835265-21956-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of commit 799fef06123f86ff69cf754f996219e6ad1678f8 ("powerpc: Use
generic idle loop"), this applies to arch_cpu_idle() instead of cpu_idle().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ca1cd7459c4a..248ee7e5bebd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -304,7 +304,7 @@ void notrace restore_interrupts(void)
  * being re-enabled and generally sanitized the lazy irq state,
  * and in the latter case it will leave with interrupts hard
  * disabled and marked as such, so the local_irq_enable() call
- * in cpu_idle() will properly re-enable everything.
+ * in arch_cpu_idle() will properly re-enable everything.
  */
 bool prep_irq_for_idle(void)
 {
-- 
1.9.1
