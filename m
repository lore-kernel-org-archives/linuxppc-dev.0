Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXfjB1vxQzDsNn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 17:35:10 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id x24so7698918pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:35:10 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v14 14/15] selftests/powerpc: Add .gitignore file for ptrace
 executables
Date: Mon, 12 Sep 2016 15:33:24 +0800
Message-Id: <1473665605-11890-15-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
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
