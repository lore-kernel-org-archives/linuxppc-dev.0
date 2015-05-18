Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 471651A0335
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:56:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 16:26:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 30AF5E005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:29:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAuJnE1835464
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:19 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAFMiF026263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:45:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 13/13] selftests,
 powerpc: Add gitignore file for the new DSCR tests
Date: Mon, 18 May 2015 16:26:16 +0530
Message-Id: <1431946576-1009-14-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
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
