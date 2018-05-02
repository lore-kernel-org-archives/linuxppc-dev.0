Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdqh2J2szF2ST
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:08:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [RFC PATCH 4/4] powerpc/stacktrace: Update copyright
Date: Wed,  2 May 2018 23:07:29 +1000
Message-Id: <20180502130729.24077-4-mpe@ellerman.id.au>
In-Reply-To: <20180502130729.24077-1-mpe@ellerman.id.au>
References: <20180502130729.24077-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This now has new code in it written by Nick and I, and switch to a
SPDX tag.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/stacktrace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index cf4652d5df80..8f032747b96d 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- * Stack trace utility
+ * Stack trace utility functions etc.
  *
  * Copyright 2008 Christoph Hellwig, IBM Corp.
- *
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
+ * Copyright 2018 Nick Piggin, Michael Ellerman, IBM Corp.
  */
 
 #include <linux/export.h>
-- 
2.14.1
