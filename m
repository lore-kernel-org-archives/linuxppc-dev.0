Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk7f52q6zDqWg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:10 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id p10so3974463lfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:10 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, mingo@kernel.org,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0233/1529] Fix typo
Date: Sat, 21 May 2016 14:07:01 +0200
Message-Id: <20160521120701.12142-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 2da41b7..7b2ca16 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1298,7 +1298,7 @@ static void h_24x7_event_read(struct perf_event *event)
 			__this_cpu_write(hv_24x7_txn_err, ret);
 		} else {
 			/*
-			 * Assoicate the event with the HCALL request index,
+			 * Associate the event with the HCALL request index,
 			 * so ->commit_txn() can quickly find/update count.
 			 */
 			i = request_buffer->num_requests - 1;
-- 
2.8.2.534.g1f66975
