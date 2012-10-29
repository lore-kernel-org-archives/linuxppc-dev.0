Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/ptrace: Fix spelling mistake
Date: Mon, 29 Oct 2012 12:13:16 +1100
Message-Id: <1351473197-27426-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1351473197-27426-1-git-send-email-mikey@neuling.org>
References: <1351473197-27426-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

s/intruction/instruction/

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/ptrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 140238a..7dd32d1 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1037,7 +1037,7 @@ void ptrace_disable(struct task_struct *child)
 }
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
-static long set_intruction_bp(struct task_struct *child,
+static long set_instruction_bp(struct task_struct *child,
 			      struct ppc_hw_breakpoint *bp_info)
 {
 	int slot;
@@ -1371,7 +1371,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		if ((bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_EXECUTE) ||
 		    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
 			return -EINVAL;
-		return set_intruction_bp(child, bp_info);
+		return set_instruction_bp(child, bp_info);
 	}
 	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
 		return set_dac(child, bp_info);
-- 
1.7.9.5
