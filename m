Return-Path: <pravin.shedge4linux@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysR0Y2pWGzDqrG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 04:47:56 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e14so2481901pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 09:47:56 -0800 (PST)
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-gpio@vger.kernel.org, john.stultz@linaro.org, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	pravin.shedge4linux@gmail.com
Subject: [PATCH 32/45] tools/testing/selftests: remove duplicate includes
Date: Wed,  6 Dec 2017 23:17:45 +0530
Message-Id: <1512582465-6581-1-git-send-email-pravin.shedge4linux@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c          | 1 -
 tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c         | 1 -
 tools/testing/selftests/timers/skew_consistency.c           | 1 -
 tools/testing/selftests/x86/mpx-dig.c                       | 2 --
 tools/testing/selftests/x86/mpx-mini-test.c                 | 4 ----
 tools/testing/selftests/x86/unwind_vdso.c                   | 1 -
 7 files changed, 11 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index 667e916..0424aaa 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
index 167135b..bf599d4 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
@@ -3,7 +3,6 @@
  * Licensed under GPLv2.
  */
 
-#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
index 137185b..be05b2c 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -14,7 +14,6 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <pthread.h>
 #include <sys/mman.h>
 #include <unistd.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711..8066be9 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607e..880fbf6 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index ec0f6b4..f17e0a1 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -722,10 +722,6 @@ void mpx_cleanup(void)
 }
 
 /*-------------- the following is test case ---------------*/
-#include <stdint.h>
-#include <stdbool.h>
-#include <stdlib.h>
-#include <stdio.h>
 #include <time.h>
 
 uint64_t num_lower_brs;
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 00a26a8..9731133 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -44,7 +44,6 @@ int main()
 #include <stdbool.h>
 #include <sys/ptrace.h>
 #include <sys/user.h>
-#include <sys/ucontext.h>
 #include <link.h>
 #include <sys/auxv.h>
 #include <dlfcn.h>
-- 
2.7.4
