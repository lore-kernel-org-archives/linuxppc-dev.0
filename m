Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FRWz44wHzF1JL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 23:21:35 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5QDIcjl131070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 09:21:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jukycexhn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 09:21:32 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 26 Jun 2018 09:21:30 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] selftests/powerpc: Fix typos
Date: Tue, 26 Jun 2018 10:20:13 -0300
In-Reply-To: <1530019213-2347-1-git-send-email-leitao@debian.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <1530019213-2347-1-git-send-email-leitao@debian.org>
Message-Id: <1530019213-2347-2-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix two typos in the file header. Replacing the word 'priviledged'
by 'privileged' and 'exuecuted' by 'executed'.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
index 55c55f39b6a6..c8c240accc0c 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
@@ -5,8 +5,8 @@
  * verifies that the child is using the changed DSCR using mfspr.
  *
  * When using the privilege state SPR, the instructions such as
- * mfspr or mtspr are priviledged and the kernel emulates them
- * for us. Instructions using problem state SPR can be exuecuted
+ * mfspr or mtspr are privileged and the kernel emulates them
+ * for us. Instructions using problem state SPR can be executed
  * directly without any emulation if the HW supports them. Else
  * they also get emulated by the kernel.
  *
-- 
2.16.3
