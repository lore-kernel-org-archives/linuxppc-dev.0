Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5D84DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 20:10:11 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2B9A5FB029397
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 02:10:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2B99x22028188
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 04:10:04 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org, akpm@linux-foundation.org,
	galak@kernel.crashing.org
Subject: [PATCH 03/17] Move include/asm-ppc/rio.h to include/asm-powerpc/rio.h
Date: Tue, 11 Mar 2008 17:07:44 +0800
Message-Id: <1205226478-7641-3-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1205226478-7641-2-git-send-email-wei.zhang@freescale.com>
References: <1205226478-7641-1-git-send-email-wei.zhang@freescale.com>
	<1205226478-7641-2-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 include/asm-powerpc/rio.h |   18 ++++++++++++++++++
 include/asm-ppc/rio.h     |   18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 include/asm-powerpc/rio.h
 delete mode 100644 include/asm-ppc/rio.h

diff --git a/include/asm-powerpc/rio.h b/include/asm-powerpc/rio.h
new file mode 100644
index 0000000..0018bf8
--- /dev/null
+++ b/include/asm-powerpc/rio.h
@@ -0,0 +1,18 @@
+/*
+ * RapidIO architecture support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef ASM_PPC_RIO_H
+#define ASM_PPC_RIO_H
+
+extern void platform_rio_init(void);
+
+#endif				/* ASM_PPC_RIO_H */
diff --git a/include/asm-ppc/rio.h b/include/asm-ppc/rio.h
deleted file mode 100644
index 0018bf8..0000000
--- a/include/asm-ppc/rio.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * RapidIO architecture support
- *
- * Copyright 2005 MontaVista Software, Inc.
- * Matt Porter <mporter@kernel.crashing.org>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef ASM_PPC_RIO_H
-#define ASM_PPC_RIO_H
-
-extern void platform_rio_init(void);
-
-#endif				/* ASM_PPC_RIO_H */
-- 
1.5.4
