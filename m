Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34DB8DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 13:11:39 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n383BZB3020862
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 22:11:36 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix compile warning
Date: Tue,  7 Apr 2009 22:11:35 -0500
Message-Id: <1239160295-14314-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/tlb_nohash.c: In function 'flush_tlb_mm':
arch/powerpc/mm/tlb_nohash.c:128: warning: unused variable 'cpu_mask'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/tlb_nohash.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 7af7297..ad2eb4d 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -125,7 +125,6 @@ static void do_flush_tlb_page_ipi(void *param)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	cpumask_t cpu_mask;
 	unsigned int pid;
 
 	preempt_disable();
-- 
1.6.0.6
