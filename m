Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F680DEA41
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:01 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 44/60] microblaze_v4: clinkage.h linkage.h sections.h
	kmap_types.h
Date: Thu, 26 Jun 2008 14:30:13 +0200
Message-Id: <1214483429-32360-45-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-44-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
	<1214483429-32360-33-git-send-email-monstr@seznam.cz>
	<1214483429-32360-34-git-send-email-monstr@seznam.cz>
	<1214483429-32360-35-git-send-email-monstr@seznam.cz>
	<1214483429-32360-36-git-send-email-monstr@seznam.cz>
	<1214483429-32360-37-git-send-email-monstr@seznam.cz>
	<1214483429-32360-38-git-send-email-monstr@seznam.cz>
	<1214483429-32360-39-git-send-email-monstr@seznam.cz>
	<1214483429-32360-40-git-send-email-monstr@seznam.cz>
	<1214483429-32360-41-git-send-email-monstr@seznam.cz>
	<1214483429-32360-42-git-send-email-monstr@seznam.cz>
	<1214483429-32360-43-git-send-email-monstr@seznam.cz>
	<1214483429-32360-44-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/clinkage.h   |   27 +++++++++++++++++++++++++++
 include/asm-microblaze/kmap_types.h |   29 +++++++++++++++++++++++++++++
 include/asm-microblaze/linkage.h    |   15 +++++++++++++++
 include/asm-microblaze/sections.h   |   21 +++++++++++++++++++++
 4 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/clinkage.h
 create mode 100644 include/asm-microblaze/kmap_types.h
 create mode 100644 include/asm-microblaze/linkage.h
 create mode 100644 include/asm-microblaze/sections.h

diff --git a/include/asm-microblaze/clinkage.h b/include/asm-microblaze/clinkage.h
new file mode 100644
index 0000000..a2e09bd
--- /dev/null
+++ b/include/asm-microblaze/clinkage.h
@@ -0,0 +1,27 @@
+/*
+ * Macros to reflect C symbol-naming conventions
+ *
+ * Copyright (C) 2003 John Williams <jwilliams@itee.uq.edu.au>
+ * Copyright (C) 2001,2002 NEC Corporatione
+ * Copyright (C) 2001,2002 Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ * Microblaze port by John Williams
+ */
+
+#ifndef _ASM_MICROBLAZE_CLINKAGE_H
+#define _ASM_MICROBLAZE_CLINKAGE_H
+
+#define __ASSEMBLY__
+
+#include <linux/linkage.h>
+
+#define C_SYMBOL_NAME(name)	name
+#define C_ENTRY(name)		.globl name; .align 4; name
+#define C_END(name)
+
+#endif /* _ASM_MICROBLAZE_CLINKAGE_H */
diff --git a/include/asm-microblaze/kmap_types.h b/include/asm-microblaze/kmap_types.h
new file mode 100644
index 0000000..4d7e222
--- /dev/null
+++ b/include/asm-microblaze/kmap_types.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_KMAP_TYPES_H
+#define _ASM_MICROBLAZE_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR,
+};
+
+#endif /* _ASM_MICROBLAZE_KMAP_TYPES_H */
diff --git a/include/asm-microblaze/linkage.h b/include/asm-microblaze/linkage.h
new file mode 100644
index 0000000..3a8e36d
--- /dev/null
+++ b/include/asm-microblaze/linkage.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_LINKAGE_H
+#define _ASM_MICROBLAZE_LINKAGE_H
+
+#define __ALIGN		.align 4
+#define __ALIGN_STR	".align 4"
+
+#endif /* _ASM_MICROBLAZE_LINKAGE_H */
diff --git a/include/asm-microblaze/sections.h b/include/asm-microblaze/sections.h
new file mode 100644
index 0000000..d0c12fd
--- /dev/null
+++ b/include/asm-microblaze/sections.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_SECTIONS_H
+#define _ASM_MICROBLAZE_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char _ssbss[], _esbss[];
+extern unsigned long __ivt_start[], __ivt_end[];
+
+#ifdef CONFIG_MTD_UCLINUX
+extern char *_ebss;
+#endif
+
+#endif /* _ASM_MICROBLAZE_SECTIONS_H */
-- 
1.5.4.GIT
