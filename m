Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/tm: Update cause codes documentation
Date: Mon, 27 May 2013 14:09:38 +1000
Message-Id: <1369627781-31088-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1369627781-31088-1-git-send-email-mikey@neuling.org>
References: <1369627781-31088-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # 3.9 only
---
 Documentation/powerpc/transactional_memory.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index c907be4..84e04a0 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -155,6 +155,7 @@ These are defined in <asm/reg.h>, and distinguish different reasons why the
 kernel aborted a transaction:
 
  TM_CAUSE_RESCHED       Thread was rescheduled.
+ TM_CAUSE_TLBI          Software TLB invalide.
  TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
  TM_CAUSE_SYSCALL       Currently unused; future syscalls that must abort
                         transactions for consistency will use this.
-- 
1.7.10.4
