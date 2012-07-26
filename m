Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 18/18] powerpc: Remove <asm/abs_addr.h>
Date: Thu, 26 Jul 2012 17:20:04 +1000
Message-Id: <1343287204-7700-18-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It contains no code and is not included by anyone.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/abs_addr.h |   22 ----------------------
 1 file changed, 22 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/abs_addr.h

diff --git a/arch/powerpc/include/asm/abs_addr.h b/arch/powerpc/include/asm/abs_addr.h
deleted file mode 100644
index dc667d4..0000000
--- a/arch/powerpc/include/asm/abs_addr.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef _ASM_POWERPC_ABS_ADDR_H
-#define _ASM_POWERPC_ABS_ADDR_H
-#ifdef __KERNEL__
-
-
-/*
- * c 2001 PPC 64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/memblock.h>
-
-#include <asm/types.h>
-#include <asm/page.h>
-#include <asm/prom.h>
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_POWERPC_ABS_ADDR_H */
-- 
1.7.9.5
