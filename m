Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76B981A0232
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:51:28 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A8BF140DA0
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:51:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:51:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EFE022CE8052
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:51:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98EpDxC37552198
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:51:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EopUD009633
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:50:53 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V9 28/28] selftests,
 powerpc: Add .gitignore file for ptrace executables
Date: Thu,  8 Oct 2015 20:17:49 +0530
Message-Id: <1444315669-23487-29-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a .gitignore file for all the executables in
the ptrace test directory thus making invisible with git status
query.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/.gitignore | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/.gitignore

diff --git a/tools/testing/selftests/powerpc/ptrace/.gitignore b/tools/testing/selftests/powerpc/ptrace/.gitignore
new file mode 100644
index 0000000..bdf3566
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/.gitignore
@@ -0,0 +1,11 @@
+ptrace-ebb
+ptrace-gpr
+ptrace-tm-gpr
+ptrace-tm-spd-gpr
+ptrace-tar
+ptrace-tm-tar
+ptrace-tm-spd-tar
+ptrace-vsx
+ptrace-tm-vsx
+ptrace-tm-spd-vsx
+ptrace-tm-spr
-- 
2.1.0
