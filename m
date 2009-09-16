Return-Path: <weiyi.huang@gmail.com>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203]) by ozlabs.org (Postfix) with ESMTP id 01963B7B70
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 23:09:21 +1000 (EST)
Received: by pzk41 with SMTP id 41so4228244pzk.4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 06:09:20 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
To: galak@kernel.crashing.org
Subject: [PATCH 7/9] powerpc/book3e-64: remove duplicated #include
Date: Wed, 16 Sep 2009 21:08:58 +0800
Message-Id: <1253106538-2512-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated #include('s) in
  arch/powerpc/kernel/exceptions-64e.S

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 9048f96..24dcc0e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -17,7 +17,6 @@
 #include <asm/cputable.h>
 #include <asm/setup.h>
 #include <asm/thread_info.h>
-#include <asm/reg.h>
 #include <asm/exception-64e.h>
 #include <asm/bug.h>
 #include <asm/irqflags.h>
-- 
1.6.1.3
