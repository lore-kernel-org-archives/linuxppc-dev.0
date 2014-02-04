Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 102C92C0365
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 22:31:42 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 17:01:39 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EA507394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 17:01:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14BVVmU29556952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:32 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14BVa6c001707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:36 +0530
Received: from deepthi.in.ibm.com (deepthi.in.ibm.com [9.124.35.236] (may be
 forged))
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s14BValR001697
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:36 +0530
Subject: [PATCH V5 2/3] powernv: Correct spell error in opal-elog.c
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 17:01:56 +0530
Message-ID: <20140204113154.19141.2070.stgit@deepthi.in.ibm.com>
In-Reply-To: <20140204113127.19141.21493.stgit@deepthi.in.ibm.com>
References: <20140204113127.19141.21493.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct spell error in opal-elog.c

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index c9ce835..90ccb70 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -26,7 +26,7 @@
 /* Maximum size of a single log on FSP is 16KB */
 #define OPAL_MAX_ERRLOG_SIZE	16384
 
-/* maximu number of records powernv can hold */
+/* Maximum number of records powernv platform can hold */
 #define MAX_NUM_RECORD	128
 
 struct opal_err_log {
