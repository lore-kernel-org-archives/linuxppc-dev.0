Return-Path: <anju@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E99421A1AA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:59:42 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 11:29:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 602F43940069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 11:29:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0B5xY4b3539418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 11:29:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0B5xXCG020025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 11:29:34 +0530
From: Anju T <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10 1/4] perf/powerpc: assign an id to each powerpc register
Date: Mon, 11 Jan 2016 11:29:28 +0530
Message-Id: <1452491971-13754-2-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1452491971-13754-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1452491971-13754-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The enum definition assigns an 'id' to each register in "struct pt_regs"
of arch/powerpc. The order of these values in the enum definition are
based on the corresponding macros in arch/powerpc/include/uapi/asm/ptrace.h.

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
Reviewed-by  : Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/perf_regs.h | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..cfbd068
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_POWERPC_PERF_REGS_H
+#define _ASM_POWERPC_PERF_REGS_H
+
+enum perf_event_powerpc_regs {
+	PERF_REG_POWERPC_GPR0,
+	PERF_REG_POWERPC_GPR1,
+	PERF_REG_POWERPC_GPR2,
+	PERF_REG_POWERPC_GPR3,
+	PERF_REG_POWERPC_GPR4,
+	PERF_REG_POWERPC_GPR5,
+	PERF_REG_POWERPC_GPR6,
+	PERF_REG_POWERPC_GPR7,
+	PERF_REG_POWERPC_GPR8,
+	PERF_REG_POWERPC_GPR9,
+	PERF_REG_POWERPC_GPR10,
+	PERF_REG_POWERPC_GPR11,
+	PERF_REG_POWERPC_GPR12,
+	PERF_REG_POWERPC_GPR13,
+	PERF_REG_POWERPC_GPR14,
+	PERF_REG_POWERPC_GPR15,
+	PERF_REG_POWERPC_GPR16,
+	PERF_REG_POWERPC_GPR17,
+	PERF_REG_POWERPC_GPR18,
+	PERF_REG_POWERPC_GPR19,
+	PERF_REG_POWERPC_GPR20,
+	PERF_REG_POWERPC_GPR21,
+	PERF_REG_POWERPC_GPR22,
+	PERF_REG_POWERPC_GPR23,
+	PERF_REG_POWERPC_GPR24,
+	PERF_REG_POWERPC_GPR25,
+	PERF_REG_POWERPC_GPR26,
+	PERF_REG_POWERPC_GPR27,
+	PERF_REG_POWERPC_GPR28,
+	PERF_REG_POWERPC_GPR29,
+	PERF_REG_POWERPC_GPR30,
+	PERF_REG_POWERPC_GPR31,
+	PERF_REG_POWERPC_NIP,
+	PERF_REG_POWERPC_MSR,
+	PERF_REG_POWERPC_ORIG_R3,
+	PERF_REG_POWERPC_CTR,
+	PERF_REG_POWERPC_LNK,
+	PERF_REG_POWERPC_XER,
+	PERF_REG_POWERPC_CCR,
+	PERF_REG_POWERPC_TRAP,
+	PERF_REG_POWERPC_DAR,
+	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_MAX,
+};
+#endif /* _ASM_POWERPC_PERF_REGS_H */
-- 
2.1.0
