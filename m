Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 808E31A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:57:15 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/kdump: crash_dump.c needs to include io.h
Date: Wed, 24 Sep 2014 15:57:12 +1000
Message-Id: <1411538232-31516-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
References: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For __ioremap().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/crash_dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 7a13f378ca2c..c78e6dac4d7d 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -13,6 +13,7 @@
 
 #include <linux/crash_dump.h>
 #include <linux/bootmem.h>
+#include <linux/io.h>
 #include <linux/memblock.h>
 #include <asm/code-patching.h>
 #include <asm/kdump.h>
-- 
1.9.1
