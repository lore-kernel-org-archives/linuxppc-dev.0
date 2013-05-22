Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 977F32C00A7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 16:23:13 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:49:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 363E2E0055
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:55:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M6N1mb31916124
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M6N75P011800
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 06:23:08 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf,
 documentation: Description for conditional branch filter
Date: Wed, 22 May 2013 11:52:41 +0530
Message-Id: <1369203761-12649-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, peterz@infradead.org,
 eranian@google.com, mingo@kernel.org
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
---
 tools/perf/Documentation/perf-record.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d4da111..8b5e1ed 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -169,12 +169,13 @@ following filters are defined:
         - any_call: any function call or system call
         - any_ret: any function return or system call return
         - ind_call: any indirect branch
+        - cond: conditional branches
         - u:  only when the branch target is at the user level
         - k: only when the branch target is in the kernel
         - hv: only when the target is at the hypervisor level
 
 +
-The option requires at least one branch type among any, any_call, any_ret, ind_call.
+The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
 The privilege levels may be omitted, in which case, the privilege levels of the associated
 event are applied to the branch filter. Both kernel (k) and hypervisor (hv) privilege
 levels are subject to permissions.  When sampling on multiple events, branch stack sampling
-- 
1.7.11.7
