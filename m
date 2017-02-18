Return-Path: <simachijun@qq.com>
Received: from smtpbg123.qq.com (smtpbg123.qq.com [183.60.2.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQXT06pqzzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 01:33:54 +1100 (AEDT)
From: Chijun Sima <simachijun@qq.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Chijun Sima <simachijun@qq.com>
Subject: [PATCH] tools/testing/selftests/powerpc: remove redundant CFLAGS in
 Makefile: "-Wall -O2 -Wall" -> "-O2 -Wall"
Date: Sat, 18 Feb 2017 22:25:59 +0800
Message-Id: <20170218142559.28467-1-simachijun@qq.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are repeated compiler flags "-Wall" in the Makefile.

The redundant compiler flag appears to have been there from the
 introduction of the Makefile.

Signed-off-by: Chijun Sima <simachijun@qq.com>
---
 tools/testing/selftests/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index c2c4211..4dbc10e 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -8,7 +8,7 @@ ifeq ($(ARCH),powerpc)
 
 GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
 
-CFLAGS := -std=gnu99 -Wall -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR)/include $(CFLAGS)
+CFLAGS := -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR)/include $(CFLAGS)
 
 export CFLAGS
 
-- 
2.9.3
