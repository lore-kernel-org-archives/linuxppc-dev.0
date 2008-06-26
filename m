Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86D72DE5B0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:15 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 48/60] microblaze_v4: headers simple files - empty or redirect
	to asm-generic
Date: Thu, 26 Jun 2008 14:30:17 +0200
Message-Id: <1214483429-32360-49-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-48-git-send-email-monstr@seznam.cz>
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
	<1214483429-32360-45-git-send-email-monstr@seznam.cz>
	<1214483429-32360-46-git-send-email-monstr@seznam.cz>
	<1214483429-32360-47-git-send-email-monstr@seznam.cz>
	<1214483429-32360-48-git-send-email-monstr@seznam.cz>
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
 include/asm-microblaze/cputime.h           |    1 +
 include/asm-microblaze/div64.h             |    1 +
 include/asm-microblaze/emergency-restart.h |    1 +
 include/asm-microblaze/errno.h             |    1 +
 include/asm-microblaze/futex.h             |    1 +
 include/asm-microblaze/kdebug.h            |    1 +
 include/asm-microblaze/local.h             |    1 +
 include/asm-microblaze/mutex.h             |    1 +
 include/asm-microblaze/namei.h             |   22 ++++++++++++++++++++++
 include/asm-microblaze/percpu.h            |    1 +
 include/asm-microblaze/resource.h          |    1 +
 11 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/auxvec.h
 create mode 100644 include/asm-microblaze/cputime.h
 create mode 100644 include/asm-microblaze/div64.h
 create mode 100644 include/asm-microblaze/emergency-restart.h
 create mode 100644 include/asm-microblaze/errno.h
 create mode 100644 include/asm-microblaze/futex.h
 create mode 100644 include/asm-microblaze/kdebug.h
 create mode 100644 include/asm-microblaze/local.h
 create mode 100644 include/asm-microblaze/mutex.h
 create mode 100644 include/asm-microblaze/namei.h
 create mode 100644 include/asm-microblaze/percpu.h
 create mode 100644 include/asm-microblaze/resource.h
 create mode 100644 include/asm-microblaze/user.h

diff --git a/include/asm-microblaze/auxvec.h b/include/asm-microblaze/auxvec.h
new file mode 100644
index 0000000..e69de29
diff --git a/include/asm-microblaze/cputime.h b/include/asm-microblaze/cputime.h
new file mode 100644
index 0000000..6d68ad7
--- /dev/null
+++ b/include/asm-microblaze/cputime.h
@@ -0,0 +1 @@
+#include <asm-generic/cputime.h>
diff --git a/include/asm-microblaze/div64.h b/include/asm-microblaze/div64.h
new file mode 100644
index 0000000..6cd978c
--- /dev/null
+++ b/include/asm-microblaze/div64.h
@@ -0,0 +1 @@
+#include <asm-generic/div64.h>
diff --git a/include/asm-microblaze/emergency-restart.h b/include/asm-microblaze/emergency-restart.h
new file mode 100644
index 0000000..3711bd9
--- /dev/null
+++ b/include/asm-microblaze/emergency-restart.h
@@ -0,0 +1 @@
+#include <asm-generic/emergency-restart.h>
diff --git a/include/asm-microblaze/errno.h b/include/asm-microblaze/errno.h
new file mode 100644
index 0000000..4c82b50
--- /dev/null
+++ b/include/asm-microblaze/errno.h
@@ -0,0 +1 @@
+#include <asm-generic/errno.h>
diff --git a/include/asm-microblaze/futex.h b/include/asm-microblaze/futex.h
new file mode 100644
index 0000000..0b74582
--- /dev/null
+++ b/include/asm-microblaze/futex.h
@@ -0,0 +1 @@
+#include <asm-generic/futex.h>
diff --git a/include/asm-microblaze/kdebug.h b/include/asm-microblaze/kdebug.h
new file mode 100644
index 0000000..6ece1b0
--- /dev/null
+++ b/include/asm-microblaze/kdebug.h
@@ -0,0 +1 @@
+#include <asm-generic/kdebug.h>
diff --git a/include/asm-microblaze/local.h b/include/asm-microblaze/local.h
new file mode 100644
index 0000000..c11c530
--- /dev/null
+++ b/include/asm-microblaze/local.h
@@ -0,0 +1 @@
+#include <asm-generic/local.h>
diff --git a/include/asm-microblaze/mutex.h b/include/asm-microblaze/mutex.h
new file mode 100644
index 0000000..ff6101a
--- /dev/null
+++ b/include/asm-microblaze/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex-dec.h>
diff --git a/include/asm-microblaze/namei.h b/include/asm-microblaze/namei.h
new file mode 100644
index 0000000..61d60b8
--- /dev/null
+++ b/include/asm-microblaze/namei.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_NAMEI_H
+#define _ASM_MICROBLAZE_NAMEI_H
+
+#ifdef __KERNEL__
+
+/* This dummy routine maybe changed to something useful
+ * for /usr/gnemul/ emulation stuff.
+ * Look at asm-sparc/namei.h for details.
+ */
+#define __emul_prefix() NULL
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_MICROBLAZE_NAMEI_H */
diff --git a/include/asm-microblaze/percpu.h b/include/asm-microblaze/percpu.h
new file mode 100644
index 0000000..06a959d
--- /dev/null
+++ b/include/asm-microblaze/percpu.h
@@ -0,0 +1 @@
+#include <asm-generic/percpu.h>
diff --git a/include/asm-microblaze/resource.h b/include/asm-microblaze/resource.h
new file mode 100644
index 0000000..04bc4db
--- /dev/null
+++ b/include/asm-microblaze/resource.h
@@ -0,0 +1 @@
+#include <asm-generic/resource.h>
diff --git a/include/asm-microblaze/user.h b/include/asm-microblaze/user.h
new file mode 100644
index 0000000..e69de29
-- 
1.5.4.GIT
