Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D55F1402D5
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 19:11:04 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 14:41:01 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5A1093940068
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 14:40:57 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s459B3Wg59572350
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:41:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s459As9B024989
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:40:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V6 04/11] perf,
 documentation: Description for conditional branch filter
Date: Mon,  5 May 2014 14:39:06 +0530
Message-Id: <1399280953-31442-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding documentation support for conditional branch filter.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Reviewed-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c71b0f3..d460049 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -184,9 +184,10 @@ following filters are defined:
 	- in_tx: only when the target is in a hardware transaction
 	- no_tx: only when the target is not in a hardware transaction
 	- abort_tx: only when the target is a hardware transaction abort
+	- cond: conditional branches
 
 +
-The option requires at least one branch type among any, any_call, any_ret, ind_call.
+The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
 The privilege levels may be omitted, in which case, the privilege levels of the associated
 event are applied to the branch filter. Both kernel (k) and hypervisor (hv) privilege
 levels are subject to permissions.  When sampling on multiple events, branch stack sampling
-- 
1.7.11.7
