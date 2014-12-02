Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 985351A05EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:57:57 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3D30D1402BF
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 18:57:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 17:57:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 326E02CE8075
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 18:57:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB27vtvM42664052
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 18:57:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB27vqMr017970
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 18:57:54 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V6 8/9] selftests,
 powerpc: Make GIT ignore all binaries related to TM
Date: Tue,  2 Dec 2014 13:26:52 +0530
Message-Id: <1417507013-11948-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1417507013-11948-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1417507013-11948-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch includes all the TM test binaries into the .gitignore
file listing in the same directory. This will make sure that GIT
ignores all of them while displaying status.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/tm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
new file mode 100644
index 0000000..71f9f9d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -0,0 +1,2 @@
+tm-ptrace
+tm-resched-dscr
-- 
1.9.3
