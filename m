Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 361DBDE737
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:37:00 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 35/60] microblaze_v4: definitions of types
Date: Thu, 26 Jun 2008 14:30:04 +0200
Message-Id: <1214483429-32360-36-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-35-git-send-email-monstr@seznam.cz>
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
 include/asm-microblaze/posix_types.h |   69 ++++++++++++++++++++++++++++++++++
 include/asm-microblaze/types.h       |   62 ++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/posix_types.h
 create mode 100644 include/asm-microblaze/types.h

diff --git a/include/asm-microblaze/posix_types.h b/include/asm-microblaze/posix_types.h
new file mode 100644
index 0000000..4e6412d
--- /dev/null
+++ b/include/asm-microblaze/posix_types.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_POSIX_TYPES_H
+#define _ASM_MICROBLAZE_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc. Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned long	__kernel_ino_t;
+typedef unsigned int	__kernel_mode_t;
+typedef unsigned int	__kernel_nlink_t;
+typedef long		__kernel_off_t;
+typedef int		__kernel_pid_t;
+typedef unsigned int	__kernel_ipc_pid_t;
+typedef unsigned int	__kernel_uid_t;
+typedef unsigned int	__kernel_gid_t;
+typedef unsigned int	__kernel_size_t;
+typedef int		__kernel_ssize_t;
+typedef int		__kernel_ptrdiff_t;
+typedef long		__kernel_time_t;
+typedef long		__kernel_suseconds_t;
+typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
+typedef int		__kernel_daddr_t;
+typedef char *		__kernel_caddr_t;
+typedef unsigned short	__kernel_uid16_t;
+typedef unsigned short	__kernel_gid16_t;
+typedef unsigned int	__kernel_uid32_t;
+typedef unsigned int	__kernel_gid32_t;
+
+#ifdef __GNUC__
+typedef long long	__kernel_loff_t;
+#endif
+
+typedef struct {
+#if defined(__KERNEL__) || defined(__USE_ALL)
+	int	val[2];
+#else /* !defined(__KERNEL__) && !defined(__USE_ALL) */
+	int	__val[2];
+#endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
+} __kernel_fsid_t;
+
+#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+
+#undef	__FD_SET
+#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
+
+#undef	__FD_CLR
+#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
+
+#undef	__FD_ISSET
+#define	__FD_ISSET(d, set)	(!!((set)->fds_bits[__FDELT(d)] & __FDMASK(d)))
+
+#undef	__FD_ZERO
+#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
+
+#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
+
+#endif /* _ASM_MICROBLAZE_POSIX_TYPES_H */
diff --git a/include/asm-microblaze/types.h b/include/asm-microblaze/types.h
new file mode 100644
index 0000000..449ab8d
--- /dev/null
+++ b/include/asm-microblaze/types.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_TYPES_H
+#define _ASM_MICROBLAZE_TYPES_H
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned short umode_t;
+
+/*
+ * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
+ * header files exported to user space
+ */
+
+typedef __signed__ char __s8;
+typedef unsigned char __u8;
+
+typedef __signed__ short __s16;
+typedef unsigned short __u16;
+
+typedef __signed__ int __s32;
+typedef unsigned int __u32;
+
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#endif
+
+/*
+ * These aren't exported outside the kernel to avoid name space clashes
+ */
+#ifdef __KERNEL__
+
+typedef __signed__ char s8;
+typedef unsigned char u8;
+
+typedef __signed__ short s16;
+typedef unsigned short u16;
+
+typedef __signed__ int s32;
+typedef unsigned int u32;
+
+typedef __signed__ long long s64;
+typedef unsigned long long u64;
+
+
+#define BITS_PER_LONG 32
+
+/* Dma addresses are 32-bits wide. */
+
+typedef u32 dma_addr_t;
+
+#endif/* __KERNEL__ */
+#endif
+
+#endif /* _ASM_MICROBLAZE_TYPES_H */
-- 
1.5.4.GIT
