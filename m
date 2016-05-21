Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk4r4gTxzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:44 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id u2so696097lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:44 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, anton@samba.org, khandual@linux.vnet.ibm.com,
 mikey@neuling.org, wei.guo.simon@gmail.com, cyrilbur@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0217/1529] Fix typo
Date: Sat, 21 May 2016 14:04:33 +0200
Message-Id: <20160521120433.11260-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 009fab1..c0c27bd 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -224,7 +224,7 @@ struct thread_struct {
 	unsigned int	align_ctl;	/* alignment handling control */
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
-	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	unsigned long	accum_tb;	/* Total accumulated purr for process */
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	struct perf_event *ptrace_bps[HBP_NUM];
 	/*
-- 
2.8.2.534.g1f66975
