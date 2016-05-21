Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk7S4f2nzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:00 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id t6so64651lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:00 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, mingo@kernel.org, sukadev@linux.vnet.ibm.com,
 peterz@infradead.org, khandual@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0232/1529] Fix typo
Date: Sat, 21 May 2016 14:06:52 +0200
Message-Id: <20160521120652.12055-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/perf/core-book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 97a1d40..4708608 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -992,7 +992,7 @@ static u64 check_and_compute_delta(u64 prev, u64 val)
 	 * than the previous value it will cause the delta and the counter to
 	 * have bogus values unless we rolled a counter over.  If a coutner is
 	 * rolled back, it will be smaller, but within 256, which is the maximum
-	 * number of events to rollback at once.  If we dectect a rollback
+	 * number of events to rollback at once.  If we detect a rollback
 	 * return 0.  This can lead to a small lack of precision in the
 	 * counters.
 	 */
-- 
2.8.2.534.g1f66975
