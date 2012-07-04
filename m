Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add a symbol for hypervisor trampolines
Date: Wed,  4 Jul 2012 16:29:41 +1000
Message-Id: <1341383381-13596-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Purely for cosmetic purposes, otherwise it can appear that we are in
single_step_pSeries() which is slightly confusing.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1c06d29..211b28d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -239,6 +239,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	 * out of line to handle them
 	 */
 	. = 0xe00
+hv_exception_trampoline:
 	b	h_data_storage_hv
 	. = 0xe20
 	b	h_instr_storage_hv
-- 
1.7.9.5
