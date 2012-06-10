Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews07.kpnxchange.com (cpsmtpb-ews07.kpnxchange.com
 [213.75.39.10]) by ozlabs.org (Postfix) with ESMTP id E6A00B6FD7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2012 19:55:34 +1000 (EST)
Message-ID: <1339321335.30984.29.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: Kill flatdevtree_env.h too
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Sun, 10 Jun 2012 11:42:15 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 430b01e8f5e524a2bfa50074d97d0bdc2505807b ("[POWERPC] Kill
flatdevtree.c") killed the two files including flatdevtree_env.h. It was
apparently just an oversight to not kill that header too. Kill it now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only.

 arch/powerpc/boot/flatdevtree_env.h |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/boot/flatdevtree_env.h

diff --git a/arch/powerpc/boot/flatdevtree_env.h b/arch/powerpc/boot/flatdevtree_env.h
deleted file mode 100644
index 66e0ebb..0000000
--- a/arch/powerpc/boot/flatdevtree_env.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * This file adds the header file glue so that the shared files
- * flatdevicetree.[ch] can compile and work in the powerpc bootwrapper.
- *
- * strncmp & strchr copied from <file:lib/string.c>
- * Copyright (C) 1991, 1992  Linus Torvalds
- *
- * Maintained by: Mark A. Greer <mgreer@mvista.com>
- */
-#ifndef _PPC_BOOT_FLATDEVTREE_ENV_H_
-#define _PPC_BOOT_FLATDEVTREE_ENV_H_
-
-#include <stdarg.h>
-#include <stddef.h>
-#include "types.h"
-#include "string.h"
-#include "stdio.h"
-#include "ops.h"
-
-#define be16_to_cpu(x)		(x)
-#define cpu_to_be16(x)		(x)
-#define be32_to_cpu(x)		(x)
-#define cpu_to_be32(x)		(x)
-#define be64_to_cpu(x)		(x)
-#define cpu_to_be64(x)		(x)
-
-#endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */
-- 
1.7.7.6
