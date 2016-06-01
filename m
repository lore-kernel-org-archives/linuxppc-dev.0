Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKm2X5CM9zDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 08:57:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 62so5545131pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 15:57:08 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/asm: Remove unused symbols in asm-offsets.c
Date: Thu,  2 Jun 2016 08:56:47 +1000
Message-Id: <1464821807-3154-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

THREAD_DSCR: Added in commit efcac6589a27 ("powerpc: Per process DSCR +
some fixes (try#4)") and last usage was removed in commit 152d523e6307
("powerpc: Create context switch helpers save_sprs() and
restore_sprs()")
---
THREAD_DSCR_INHERIT: Added in commit 714332858bfd ("powerpc: Restore
correct DSCR in context switch") and last usage was removed in commit
152d523e6307 ("powerpc: Create context switch helpers save_sprs() and
restore_sprs()")
---
THREAD_TAR: Added in commit 2468dcf641e4 ("powerpc: Add support for
context switching the TAR register") and last usage was removed in
commit 152d523e6307 ("powerpc: Create context switch helpers save_sprs()
and restore_sprs()")
---
THREAD_BESCR, THREAD_EBBHR and THREAD_EBBRR: Added in commit
9353374b8e15 ("powerpc: Context switch the new EBB SPRs") and last usage
was removed in commit 152d523e6307 ("powerpc: Create context switch
helpers save_sprs() and restore_sprs()")
---
THREAD_SIAR, THREAD_SDAR, THREAD_SIER, THREAD_MMCR0, and THREAD_MMCR2:
Added commit 59affcd3e460 ("powerpc: Context switch more PMU related
SPRs") and last usage was removed in commit b11ae95100f7 ("powerpc:
Partial revert of "Context switch more PMU related SPRs"")
---
PACA_LOCK_TOKEN: Added commit 9e368f291560 ("KVM: PPC: book3s_hv: Add
support for PPC970-family processors") and last usage was removed in
commit c17b98cf6028 ("KVM: PPC: Book3S HV: Remove code for PPC970
processors")
---
HCALL_STAT_SIZE, HCALL_STAT_CALLS, HCALL_STAT_TB and HCALL_STAT_PURR:
Added in commit 57852a853b0d ("[POWERPC] powerpc: Instrument Hypervisor
Calls") and last usage was removed in commit c8cd093a6e9f ("powerpc:
tracing: Add hypervisor call tracepoints")
---
VCPU_EPLC: Added in commit d30f6e480055 ("KVM: PPC: booke: category E.HV
(GS-mode) support") and was never used.
---
CPU_DOWN_FLUSH: Added in commit e7affb1dba0e ("powerpc/cache: add cache
flush operation for various e500") and was never used.
---
CFG_STAMP_XSEC: Added in commit commit 14cf11af6cf6 ("powerpc: Merge
enough to start building in arch/powerpc.") and last usage was removed
in commit 0e469db8f70c ("powerpc: Rework VDSO gettimeofday to prevent
time going backwards")
---
KVM_LPCR: Added in commit aa04b4cc5be6 ("KVM: PPC: Allocate RMAs (Real
Mode Areas) at boot for use by guests") and last usage was removed in
commit a0144e2a6b0b ("KVM: PPC: Book3S HV: Store LPCR value for each
virtual core")
---
GPR15, GPR16, GPR17, GPR18, GPR19, GPR20, GPR21, GPR22, GPR23, GPR24,
GPR25, GPR26, GPR27, GPR28, GPR29 and GPR30: Added in commit
a4bcbe6a41ad ("powerpc: Remove old compile time disabled syscall tracing
code") and were never used.
---
GPR31: Added in commit a4bcbe6a41ad ("powerpc: Remove old compile time
disabled syscall tracing code") and last usage was removed in commit
a4bcbe6a41ad ("powerpc: Remove old compile time disabled syscall tracing
code")
---
VCPU_SPMC: Added in commit b005255e12a3 ("KVM: PPC: Book3S HV:
Context-switch new POWER8 SPRs") and was never used.
---
VCPU_SHADOW_FSCR: Added in commit 616dff860282 ("KVM: PPC: Book3S PR:
Handle Facility interrupt and FSCR") and was never used.
---
VCPU_SHADOW_SRR1: Added in commit a2d56020d1d9 ("KVM: PPC: Book3S PR:
Keep volatile reg values in vcpu rather than shadow_vcpu") and was never
used.
---
KVM_SPLIT_SIZE: Added in commit b4deba5c41e9 ("KVM: PPC: Book3S HV:
Implement dynamicmicro-threading on POWER8") and was never used.
---
VCPU_VCPUID: Added in commit de56a948b918 ("KVM: PPC: Add support for
Book3S processors in hypervisor mode") and last usage was removed in
commit 1b400ba0cd24 ("KVM: PPC: Book3S HV: Improve handling of local vs.
global TLB invalidations")
---
_MQ: Added in commit 14cf11af6cf6 ("powerpc: Merge enough to start
building in arch/powerpc.") and never used.
---
AUDITCONTEXT: Added in commit 14cf11af6cf6 ("powerpc: Merge enough to
start building in arch/powerpc.") and last usage was removed in commit
401d1f029beb ("[PATCH] syscall entry/exit revamp")
----
CLONE_VM: Added in commit 14cf11af6cf6 ("powerpc: Merge enough to start
building in arch/powerpc.") and currently unused.
---
CLONE_UNTRACED: Added in commit 14cf11af6cf6 ("powerpc: Merge enough to
start building in arch/powerpc.") and currently unused.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c | 50 ---------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ea09551a2cd..f351f7325f20 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -74,11 +74,8 @@ int main(void)
 	DEFINE(MM, offsetof(struct task_struct, mm));
 	DEFINE(MMCONTEXTID, offsetof(struct mm_struct, context.id));
 #ifdef CONFIG_PPC64
-	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
-	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
-	DEFINE(THREAD_DSCR_INHERIT, offsetof(struct thread_struct, dscr_inherit));
 	DEFINE(TASKTHREADPPR, offsetof(struct task_struct, thread.ppr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
@@ -132,17 +129,6 @@ int main(void)
 	DEFINE(THREAD_KVM_VCPU, offsetof(struct thread_struct, kvm_vcpu));
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
-	DEFINE(THREAD_TAR, offsetof(struct thread_struct, tar));
-	DEFINE(THREAD_BESCR, offsetof(struct thread_struct, bescr));
-	DEFINE(THREAD_EBBHR, offsetof(struct thread_struct, ebbhr));
-	DEFINE(THREAD_EBBRR, offsetof(struct thread_struct, ebbrr));
-	DEFINE(THREAD_SIAR, offsetof(struct thread_struct, siar));
-	DEFINE(THREAD_SDAR, offsetof(struct thread_struct, sdar));
-	DEFINE(THREAD_SIER, offsetof(struct thread_struct, sier));
-	DEFINE(THREAD_MMCR0, offsetof(struct thread_struct, mmcr0));
-	DEFINE(THREAD_MMCR2, offsetof(struct thread_struct, mmcr2));
-#endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
 	DEFINE(THREAD_TM_TFHAR, offsetof(struct thread_struct, tm_tfhar));
@@ -178,7 +164,6 @@ int main(void)
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
-	DEFINE(PACA_LOCK_TOKEN, offsetof(struct paca_struct, lock_token));
 	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
 	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
 	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
@@ -275,12 +260,6 @@ int main(void)
 	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
 	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
 	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-
-	/* hcall statistics */
-	DEFINE(HCALL_STAT_SIZE, sizeof(struct hcall_stats));
-	DEFINE(HCALL_STAT_CALLS, offsetof(struct hcall_stats, num_calls));
-	DEFINE(HCALL_STAT_TB, offsetof(struct hcall_stats, tb_total));
-	DEFINE(HCALL_STAT_PURR, offsetof(struct hcall_stats, purr_total));
 #endif /* CONFIG_PPC64 */
 	DEFINE(GPR0, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[0]));
 	DEFINE(GPR1, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[1]));
@@ -298,23 +277,6 @@ int main(void)
 	DEFINE(GPR13, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[13]));
 #ifndef CONFIG_PPC64
 	DEFINE(GPR14, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[14]));
-	DEFINE(GPR15, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[15]));
-	DEFINE(GPR16, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[16]));
-	DEFINE(GPR17, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[17]));
-	DEFINE(GPR18, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[18]));
-	DEFINE(GPR19, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[19]));
-	DEFINE(GPR20, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[20]));
-	DEFINE(GPR21, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[21]));
-	DEFINE(GPR22, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[22]));
-	DEFINE(GPR23, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[23]));
-	DEFINE(GPR24, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[24]));
-	DEFINE(GPR25, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[25]));
-	DEFINE(GPR26, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[26]));
-	DEFINE(GPR27, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[27]));
-	DEFINE(GPR28, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[28]));
-	DEFINE(GPR29, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[29]));
-	DEFINE(GPR30, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[30]));
-	DEFINE(GPR31, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[31]));
 #endif /* CONFIG_PPC64 */
 	/*
 	 * Note: these symbols include _ because they overlap with special
@@ -332,7 +294,6 @@ int main(void)
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(_TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
 #ifndef CONFIG_PPC64
-	DEFINE(_MQ, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, mq));
 	/*
 	 * The PowerPC 400-class & Book-E processors have neither the DAR
 	 * nor the DSISR SPRs. Hence, we overload them to hold the similar
@@ -369,8 +330,6 @@ int main(void)
 	DEFINE(SAVED_KSP_LIMIT, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, saved_ksp_limit));
 #endif
 #endif
-	DEFINE(CLONE_VM, CLONE_VM);
-	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
 #ifndef CONFIG_PPC64
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
@@ -380,7 +339,6 @@ int main(void)
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
-	DEFINE(CPU_DOWN_FLUSH, offsetof(struct cpu_spec, cpu_down_flush));
 
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
@@ -395,7 +353,6 @@ int main(void)
 	DEFINE(CFG_TB_ORIG_STAMP, offsetof(struct vdso_data, tb_orig_stamp));
 	DEFINE(CFG_TB_TICKS_PER_SEC, offsetof(struct vdso_data, tb_ticks_per_sec));
 	DEFINE(CFG_TB_TO_XS, offsetof(struct vdso_data, tb_to_xs));
-	DEFINE(CFG_STAMP_XSEC, offsetof(struct vdso_data, stamp_xsec));
 	DEFINE(CFG_TB_UPDATE_COUNT, offsetof(struct vdso_data, tb_update_count));
 	DEFINE(CFG_TZ_MINUTEWEST, offsetof(struct vdso_data, tz_minuteswest));
 	DEFINE(CFG_TZ_DSTTIME, offsetof(struct vdso_data, tz_dsttime));
@@ -517,7 +474,6 @@ int main(void)
 	DEFINE(KVM_HOST_SDR1, offsetof(struct kvm, arch.host_sdr1));
 	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
 	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
-	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
@@ -528,7 +484,6 @@ int main(void)
 	DEFINE(VCPU_THREAD_CPU, offsetof(struct kvm_vcpu, arch.thread_cpu));
 #endif
 #ifdef CONFIG_PPC_BOOK3S
-	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
 	DEFINE(VCPU_PURR, offsetof(struct kvm_vcpu, arch.purr));
 	DEFINE(VCPU_SPURR, offsetof(struct kvm_vcpu, arch.spurr));
 	DEFINE(VCPU_IC, offsetof(struct kvm_vcpu, arch.ic));
@@ -551,7 +506,6 @@ int main(void)
 	DEFINE(VCPU_PRODDED, offsetof(struct kvm_vcpu, arch.prodded));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
-	DEFINE(VCPU_SPMC, offsetof(struct kvm_vcpu, arch.spmc));
 	DEFINE(VCPU_SIAR, offsetof(struct kvm_vcpu, arch.siar));
 	DEFINE(VCPU_SDAR, offsetof(struct kvm_vcpu, arch.sdar));
 	DEFINE(VCPU_SIER, offsetof(struct kvm_vcpu, arch.sier));
@@ -566,7 +520,6 @@ int main(void)
 	DEFINE(VCPU_CFAR, offsetof(struct kvm_vcpu, arch.cfar));
 	DEFINE(VCPU_PPR, offsetof(struct kvm_vcpu, arch.ppr));
 	DEFINE(VCPU_FSCR, offsetof(struct kvm_vcpu, arch.fscr));
-	DEFINE(VCPU_SHADOW_FSCR, offsetof(struct kvm_vcpu, arch.shadow_fscr));
 	DEFINE(VCPU_PSPB, offsetof(struct kvm_vcpu, arch.pspb));
 	DEFINE(VCPU_EBBHR, offsetof(struct kvm_vcpu, arch.ebbhr));
 	DEFINE(VCPU_EBBRR, offsetof(struct kvm_vcpu, arch.ebbrr));
@@ -576,7 +529,6 @@ int main(void)
 	DEFINE(VCPU_TCSCR, offsetof(struct kvm_vcpu, arch.tcscr));
 	DEFINE(VCPU_ACOP, offsetof(struct kvm_vcpu, arch.acop));
 	DEFINE(VCPU_WORT, offsetof(struct kvm_vcpu, arch.wort));
-	DEFINE(VCPU_SHADOW_SRR1, offsetof(struct kvm_vcpu, arch.shadow_srr1));
 	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_map));
 	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
 	DEFINE(VCORE_NAPPING_THREADS, offsetof(struct kvmppc_vcore, napping_threads));
@@ -693,7 +645,6 @@ int main(void)
 	DEFINE(KVM_SPLIT_RPR, offsetof(struct kvm_split_mode, rpr));
 	DEFINE(KVM_SPLIT_PMMAR, offsetof(struct kvm_split_mode, pmmar));
 	DEFINE(KVM_SPLIT_LDBAR, offsetof(struct kvm_split_mode, ldbar));
-	DEFINE(KVM_SPLIT_SIZE, offsetof(struct kvm_split_mode, subcore_size));
 	DEFINE(KVM_SPLIT_DO_NAP, offsetof(struct kvm_split_mode, do_nap));
 	DEFINE(KVM_SPLIT_NAPPED, offsetof(struct kvm_split_mode, napped));
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
@@ -756,7 +707,6 @@ int main(void)
 #ifdef CONFIG_KVM_BOOKE_HV
 	DEFINE(VCPU_HOST_MAS4, offsetof(struct kvm_vcpu, arch.host_mas4));
 	DEFINE(VCPU_HOST_MAS6, offsetof(struct kvm_vcpu, arch.host_mas6));
-	DEFINE(VCPU_EPLC, offsetof(struct kvm_vcpu, arch.eplc));
 #endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
-- 
2.5.0
