Return-Path: <weiyi.huang@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 3A9E7DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 23:34:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so647540pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 06:34:29 -0700 (PDT)
Date: Thu, 08 May 2008 21:34:29 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
To: benh@kernel.crashing.org
Subject: remove duplicated include
Message-Id: <20080508213310.895C.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed duplicated include file <asm/prom.h> in powerpc/kernel/btext.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

--- a/powerpc/kernel/btext.c    2008-05-08 21:20:20.000000000 +0800
+++ b/powerpc/kernel/btext.c    2008-05-08 21:20:38.000000000 +0800
@@ -16,7 +16,6 @@
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/processor.h>
 #include <asm/udbg.h>
