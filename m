Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E32201A0BE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:43:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 21 May 2015 12:13:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DFEDF1258056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:16:02 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L6hiQ260883094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:13:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L62Ldh008910
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 11:32:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com,
 mpe@ellerman.id.au
Subject: [PATCH V5 13/13] selftests,
 powerpc: Add gitignore file for the new DSCR tests
Date: Thu, 21 May 2015 12:13:13 +0530
Message-Id: <1432190593-17253-14-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
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
2.1.0
