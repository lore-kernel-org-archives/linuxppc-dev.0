Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABABC1A06B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:53:28 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 18:53:26 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E41011FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:44:26 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T0oBF910223890
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:50:11 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T0rGWf028154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:53:17 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 19/19] perf, tools,
 pmu-events: Add Skylake frontend MSR support
Date: Mon, 28 Sep 2015 17:50:57 -0700
Message-Id: <1443487857-26281-20-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add support for the "frontend" extra MSR on Skylake in the JSON
conversion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 247d777e..96e233e 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -126,6 +126,7 @@ static struct msrmap {
 	{ "0x3F6", "ldlat=" },
 	{ "0x1A6", "offcore_rsp=" },
 	{ "0x1A7", "offcore_rsp=" },
+	{ "0x3F7", "frontend=" },
 	{ NULL, NULL }
 };
 
-- 
2.5.3
