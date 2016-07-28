Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0GpX3DgSzDrP4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:01:24 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so2843141pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:01:24 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH v13 29/30] selftests/powerpc: Add .gitignore file for ptrace
 executables
Date: Thu, 28 Jul 2016 10:57:58 +0800
Message-Id: <1469674679-8580-30-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds a .gitignore file for all the executables in
the ptrace test directory thus making invisible with git status
query.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
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
1.8.3.1
