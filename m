Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24ACBDF323
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:25 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 49/60] microblaze_v4: headers files entry.h current.h mman.h
	registers.h sembuf.h
Date: Thu, 26 Jun 2008 14:30:18 +0200
Message-Id: <1214483429-32360-50-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-49-git-send-email-monstr@seznam.cz>
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
	<1214483429-32360-49-git-send-email-monstr@seznam.cz>
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
 include/asm-microblaze/current.h   |   23 +++++++++++++++++++++++
 include/asm-microblaze/entry.h     |   28 ++++++++++++++++++++++++++++
 include/asm-microblaze/mman.h      |   25 +++++++++++++++++++++++++
 include/asm-microblaze/registers.h |   24 ++++++++++++++++++++++++
 include/asm-microblaze/sembuf.h    |   34 ++++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/current.h
 create mode 100644 include/asm-microblaze/entry.h
 create mode 100644 include/asm-microblaze/mman.h
 create mode 100644 include/asm-microblaze/registers.h
 create mode 100644 include/asm-microblaze/sembuf.h

diff --git a/include/asm-microblaze/current.h b/include/asm-microblaze/current.h
new file mode 100644
index 0000000..bc5ec59
--- /dev/null
+++ b/include/asm-microblaze/current.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_CURRENT_H
+#define _ASM_MICROBLAZE_CURRENT_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Dedicate r31 to keeping the current task pointer
+ */
+register struct task_struct *current asm("r31");
+
+#define get_current() current
+
+#endif
+
+#endif /* _ASM_MICROBLAZE_CURRENT_H */
diff --git a/include/asm-microblaze/entry.h b/include/asm-microblaze/entry.h
new file mode 100644
index 0000000..e4b5079
--- /dev/null
+++ b/include/asm-microblaze/entry.h
@@ -0,0 +1,28 @@
+/*
+ * Definitions used by low-level trap handlers
+ *
+ * Copyright (C) 2007 PetaLogix
+ * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_ENTRY_H
+#define _ASM_MICROBLAZE_ENTRY_H
+
+#include <asm/percpu.h>
+#include <asm/ptrace.h>
+
+/* These are per-cpu variables required in entry.S, among other
+ places */
+
+DECLARE_PER_CPU(unsigned int, KSP); /* Saved kernel stack pointer */
+DECLARE_PER_CPU(unsigned int, KM); /* Kernel/user mode */
+DECLARE_PER_CPU(unsigned int, ENTRY_SP); /* Saved SP on kernel entry */
+DECLARE_PER_CPU(unsigned int, R11_SAVE); /* Temp variable for entry */
+DECLARE_PER_CPU(unsigned int, CURRENT_SAVE); /* Saved current pointer */
+DECLARE_PER_CPU(unsigned int, SYSCALL_SAVE); /* Saved syscall number */
+
+#endif /* _ASM_MICROBLAZE_ENTRY_H */
diff --git a/include/asm-microblaze/mman.h b/include/asm-microblaze/mman.h
new file mode 100644
index 0000000..4914b13
--- /dev/null
+++ b/include/asm-microblaze/mman.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_MMAN_H
+#define _ASM_MICROBLAZE_MMAN_H
+
+#include <asm-generic/mman.h>
+
+#define MAP_GROWSDOWN	0x0100 /* stack-like segment */
+#define MAP_DENYWRITE	0x0800 /* ETXTBSY */
+#define MAP_EXECUTABLE	0x1000 /* mark it as an executable */
+#define MAP_LOCKED	0x2000 /* pages are locked */
+#define MAP_NORESERVE	0x4000 /* don't check for reservations */
+#define MAP_POPULATE	0x8000 /* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000 /* do not block on IO */
+
+#define MCL_CURRENT	1 /* lock all current mappings */
+#define MCL_FUTURE	2 /* lock all future mappings */
+
+#endif /* _ASM_MICROBLAZE_MMAN_H */
diff --git a/include/asm-microblaze/registers.h b/include/asm-microblaze/registers.h
new file mode 100644
index 0000000..1a98ba0
--- /dev/null
+++ b/include/asm-microblaze/registers.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_REGISTERS_H
+#define _ASM_MICROBLAZE_REGISTERS_H
+
+#define MSR_BE	(1<<0)
+#define MSR_IE	(1<<1)
+#define MSR_C	(1<<2)
+#define MSR_BIP	(1<<3)
+#define MSR_FSL	(1<<4)
+#define MSR_ICE	(1<<5)
+#define MSR_DZ	(1<<6)
+#define MSR_DCE	(1<<7)
+#define MSR_EE	(1<<8)
+#define MSR_EIP	(1<<9)
+#define MSR_CC	(1<<31)
+
+#endif /* _ASM_MICROBLAZE_REGISTERS_H */
diff --git a/include/asm-microblaze/sembuf.h b/include/asm-microblaze/sembuf.h
new file mode 100644
index 0000000..b804ed7
--- /dev/null
+++ b/include/asm-microblaze/sembuf.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_SEMBUF_H
+#define _ASM_MICROBLAZE_SEMBUF_H
+
+/*
+ * The semid64_ds structure for microblaze architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct semid64_ds {
+	struct ipc64_perm sem_perm; /* permissions .. see ipc.h */
+	__kernel_time_t	sem_otime; /* last semop time */
+	unsigned long	__unused1;
+	__kernel_time_t	sem_ctime; /* last change time */
+	unsigned long	__unused2;
+	unsigned long	sem_nsems; /* no. of semaphores in array */
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+
+#endif /* _ASM_MICROBLAZE_SEMBUF_H */
-- 
1.5.4.GIT
