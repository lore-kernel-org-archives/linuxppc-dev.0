Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D510E1A2B44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 18:31:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 75A60357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8VMXa33554666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8Uvnr026375
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:30:57 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 13/13] selftests,
 powerpc: Add gitignore file for the new DSCR tests
Date: Fri, 10 Apr 2015 14:00:12 +0530
Message-Id: <1428654612-23539-14-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds .gitignore for all the newly added DSCR tests.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/dscr/.gitignore | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/dscr/.gitignore

diff --git a/tools/testing/selftests/powerpc/dscr/.gitignore b/tools/testing/selftests/powerpc/dscr/.gitignore
new file mode 100644
index 0000000..b585c6c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/.gitignore
@@ -0,0 +1,7 @@
+dscr_default_test
+dscr_explicit_test
+dscr_inherit_exec_test
+dscr_inherit_test
+dscr_sysfs_test
+dscr_sysfs_thread_test
+dscr_user_test
-- 
1.9.3
