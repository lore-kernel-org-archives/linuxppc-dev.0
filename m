Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk6T5xf0zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:09 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id r5so6880281lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:09 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, anton@samba.org, cyrilbur@gmail.com, mikey@neuling.org,
 khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0226/1529] Fix typo
Date: Sat, 21 May 2016 14:06:00 +0200
Message-Id: <20160521120600.11742-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e2f12cb..6d39786 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -709,7 +709,7 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
 	dawrx |= (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
 		                   >> 3; //* PRIM bits */
 	/* dawr length is stored in field MDR bits 48:53.  Matches range in
-	   doublewords (64 bits) baised by -1 eg. 0b000000=1DW and
+	   doublewords (64 bits) raised by -1 eg. 0b000000=1DW and
 	   0b111111=64DW.
 	   brk->len is in bytes.
 	   This aligns up to double word size, shifts and does the bias.
@@ -794,7 +794,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	 * this state.
 	 * We do this using the current MSR, rather tracking it in
 	 * some specific thread_struct bit, as it has the additional
-	 * benifit of checking for a potential TM bad thing exception.
+	 * benefit of checking for a potential TM bad thing exception.
 	 */
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
-- 
2.8.2.534.g1f66975
