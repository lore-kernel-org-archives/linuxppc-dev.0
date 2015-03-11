Return-Path: <fabf@skynet.be>
Received: from mailrelay109.isp.belgacom.be (mailrelay109.isp.belgacom.be
 [195.238.20.136])
 by lists.ozlabs.org (Postfix) with ESMTP id A56E31A07E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 06:13:47 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 linux-next] powerpc: use kbuild generic-y where possible
Date: Wed, 11 Mar 2015 20:13:34 +0100
Message-Id: <1426101214-6202-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace one line asm-generic include files declared in
arch/powerpc/include/asm/ by generic-y declaration
which creates arch/powerpc/include/generated/asm equivalent.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/powerpc/include/asm/Kbuild     | 4 +++-
 arch/powerpc/include/asm/div64.h    | 1 -
 arch/powerpc/include/asm/irq_regs.h | 2 --
 arch/powerpc/include/asm/local64.h  | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/div64.h
 delete mode 100644 arch/powerpc/include/asm/irq_regs.h
 delete mode 100644 arch/powerpc/include/asm/local64.h

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 382b28e..4b87205 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,6 +1,8 @@
-
 generic-y += clkdev.h
+generic-y += div64.h
+generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += rwsem.h
diff --git a/arch/powerpc/include/asm/div64.h b/arch/powerpc/include/asm/div64.h
deleted file mode 100644
index 6cd978c..0000000
--- a/arch/powerpc/include/asm/div64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/div64.h>
diff --git a/arch/powerpc/include/asm/irq_regs.h b/arch/powerpc/include/asm/irq_regs.h
deleted file mode 100644
index ba94b51..0000000
--- a/arch/powerpc/include/asm/irq_regs.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <asm-generic/irq_regs.h>
-
diff --git a/arch/powerpc/include/asm/local64.h b/arch/powerpc/include/asm/local64.h
deleted file mode 100644
index 36c93b5..0000000
--- a/arch/powerpc/include/asm/local64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local64.h>
-- 
1.9.1
