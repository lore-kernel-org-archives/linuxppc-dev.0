Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 802711A08C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:58:04 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CEF31402B6
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 18:58:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 17:58:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A1E9E2CE807F
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 18:58:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB27w0MP39256246
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 18:58:00 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB27vwA5018070
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 18:58:00 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V6 9/9] selftests: Make GIT ignore all binaries in powerpc
 test suite
Date: Tue,  2 Dec 2014 13:26:53 +0530
Message-Id: <1417507013-11948-10-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch includes all of the powerpc test binaries into the
.gitignore file listing in their respective directories. This
will make sure that GIT ignores all of these test binaries while
displaying status.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
 tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
 tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
 .../selftests/powerpc/primitives/.gitignore        |  1 +
 5 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore

diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
new file mode 100644
index 0000000..25a192f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
@@ -0,0 +1,4 @@
+copyuser_64
+copyuser_power7
+memcpy_64
+memcpy_power7
diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
new file mode 100644
index 0000000..156f4e8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -0,0 +1 @@
+hugetlb_vs_thp_test
diff --git a/tools/testing/selftests/powerpc/pmu/.gitignore b/tools/testing/selftests/powerpc/pmu/.gitignore
new file mode 100644
index 0000000..e748f33
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/.gitignore
@@ -0,0 +1,3 @@
+count_instructions
+l3_bank_test
+per_event_excludes
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
new file mode 100644
index 0000000..42bddbe
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
@@ -0,0 +1,22 @@
+reg_access_test
+event_attributes_test
+cycles_test
+cycles_with_freeze_test
+pmc56_overflow_test
+ebb_vs_cpu_event_test
+cpu_event_vs_ebb_test
+cpu_event_pinned_vs_ebb_test
+task_event_vs_ebb_test
+task_event_pinned_vs_ebb_test
+multi_ebb_procs_test
+multi_counter_test
+pmae_handling_test
+close_clears_pmcc_test
+instruction_count_test
+fork_cleanup_test
+ebb_on_child_test
+ebb_on_willing_child_test
+back_to_back_ebbs_test
+lost_exception_test
+no_handler_test
+cycles_with_mmcr2_test
diff --git a/tools/testing/selftests/powerpc/primitives/.gitignore b/tools/testing/selftests/powerpc/primitives/.gitignore
new file mode 100644
index 0000000..4cc4e31
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/.gitignore
@@ -0,0 +1 @@
+load_unaligned_zeropad
-- 
1.9.3
