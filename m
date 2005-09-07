Return-Path: <jdl@jdl.com>
From: jdl@freescale.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Wed, 07 Sep 2005 15:27:09 -0500
Message-Id: <E1ED6Vh-0005sm-JQ@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH Standardize on _ASM_POWERPC header symbol prefix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Standardize on _ASM_POWERPC_... prefix for all #include
exclusion symbols.  Fixup all the non-compliers.

 include/asm-powerpc/8253pit.h     |    8 ++++----
 include/asm-powerpc/agp.h         |    8 +++-----
 include/asm-powerpc/bugs.h        |    6 +++---
 include/asm-powerpc/errno.h       |    6 +++---
 include/asm-powerpc/ioctl.h       |    6 +++---
 include/asm-powerpc/ioctls.h      |    6 +++---
 include/asm-powerpc/linkage.h     |    6 +++---
 include/asm-powerpc/mc146818rtc.h |    6 +++---
 include/asm-powerpc/mman.h        |    6 +++---
 include/asm-powerpc/module.h      |    6 +++---
 include/asm-powerpc/namei.h       |   14 +++++++-------
 include/asm-powerpc/poll.h        |    6 +++---
 include/asm-powerpc/sembuf.h      |    6 +++---
 include/asm-powerpc/shmbuf.h      |    6 +++---
 include/asm-powerpc/shmparam.h    |    6 +++---
 include/asm-powerpc/siginfo.h     |    6 +++---
 include/asm-powerpc/socket.h      |    6 +++---
 include/asm-powerpc/sockios.h     |    6 +++---
 include/asm-powerpc/string.h      |    6 +++---
 include/asm-powerpc/termbits.h    |    6 +++---
 include/asm-powerpc/termios.h     |    6 +++---
 include/asm-powerpc/unaligned.h   |    9 +++++----
 22 files changed, 73 insertions(+), 74 deletions(-)

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


diff --git a/include/asm-powerpc/8253pit.h b/include/asm-powerpc/8253pit.h
--- a/include/asm-powerpc/8253pit.h
+++ b/include/asm-powerpc/8253pit.h
@@ -1,10 +1,10 @@
+#ifndef _ASM_POWERPC_8253PIT_H
+#define _ASM_POWERPC_8253PIT_H
+
 /*
  * 8253/8254 Programmable Interval Timer
  */
 
-#ifndef _8253PIT_H
-#define _8253PIT_H
-
 #define PIT_TICK_RATE	1193182UL
 
-#endif
+#endif	/* _ASM_POWERPC_8253PIT_H */
diff --git a/include/asm-powerpc/agp.h b/include/asm-powerpc/agp.h
--- a/include/asm-powerpc/agp.h
+++ b/include/asm-powerpc/agp.h
@@ -1,10 +1,8 @@
-#ifndef AGP_H
-#define AGP_H 1
+#ifndef _ASM_POWERPC_AGP_H
+#define _ASM_POWERPC_AGP_H
 
 #include <asm/io.h>
 
-/* nothing much needed here */
-
 #define map_page_into_agp(page)
 #define unmap_page_from_agp(page)
 #define flush_agp_mappings()
@@ -20,4 +18,4 @@
 #define free_gatt_pages(table, order)	\
 	free_pages((unsigned long)(table), (order))
 
-#endif
+#endif	/* _ASM_POWERPC_AGP_H */
diff --git a/include/asm-powerpc/bugs.h b/include/asm-powerpc/bugs.h
--- a/include/asm-powerpc/bugs.h
+++ b/include/asm-powerpc/bugs.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_BUGS_H
-#define _POWERPC_BUGS_H
+#ifndef _ASM_POWERPC_BUGS_H
+#define _ASM_POWERPC_BUGS_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -15,4 +15,4 @@
 
 extern void check_bugs(void);
 
-#endif /* _POWERPC_BUGS_H */
+#endif	/* _ASM_POWERPC_BUGS_H */
diff --git a/include/asm-powerpc/errno.h b/include/asm-powerpc/errno.h
--- a/include/asm-powerpc/errno.h
+++ b/include/asm-powerpc/errno.h
@@ -1,5 +1,5 @@
-#ifndef _PPC_ERRNO_H
-#define _PPC_ERRNO_H
+#ifndef _ASM_POWERPC_ERRNO_H
+#define _ASM_POWERPC_ERRNO_H
 
 #include <asm-generic/errno.h>
 
@@ -8,4 +8,4 @@
 
 #define _LAST_ERRNO	516
 
-#endif
+#endif	/* _ASM_POWERPC_ERRNO_H */
diff --git a/include/asm-powerpc/ioctl.h b/include/asm-powerpc/ioctl.h
--- a/include/asm-powerpc/ioctl.h
+++ b/include/asm-powerpc/ioctl.h
@@ -1,5 +1,5 @@
-#ifndef _PPC_IOCTL_H
-#define _PPC_IOCTL_H
+#ifndef _ASM_POWERPC_IOCTL_H
+#define _ASM_POWERPC_IOCTL_H
 
 
 /*
@@ -66,4 +66,4 @@ extern unsigned int __invalid_size_argum
 #define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
 #define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
 
-#endif
+#endif	/* _ASM_POWERPC_IOCTL_H */
diff --git a/include/asm-powerpc/ioctls.h b/include/asm-powerpc/ioctls.h
--- a/include/asm-powerpc/ioctls.h
+++ b/include/asm-powerpc/ioctls.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_PPC_IOCTLS_H
-#define _ASM_PPC_IOCTLS_H
+#ifndef _ASM_POWERPC_IOCTLS_H
+#define _ASM_POWERPC_IOCTLS_H
 
 #include <asm/ioctl.h>
 
@@ -104,4 +104,4 @@
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 
-#endif /* _ASM_PPC_IOCTLS_H */
+#endif	/* _ASM_POWERPC_IOCTLS_H */
diff --git a/include/asm-powerpc/linkage.h b/include/asm-powerpc/linkage.h
--- a/include/asm-powerpc/linkage.h
+++ b/include/asm-powerpc/linkage.h
@@ -1,6 +1,6 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
+#ifndef _ASM_POWERPC_LINKAGE_H
+#define _ASM_POWERPC_LINKAGE_H
 
 /* Nothing to see here... */
 
-#endif
+#endif	/* _ASM_POWERPC_LINKAGE_H */
diff --git a/include/asm-powerpc/mc146818rtc.h b/include/asm-powerpc/mc146818rtc.h
--- a/include/asm-powerpc/mc146818rtc.h
+++ b/include/asm-powerpc/mc146818rtc.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_MC146818RTC_H
-#define _POWERPC_MC146818RTC_H
+#ifndef _ASM_POWERPC_MC146818RTC_H
+#define _ASM_POWERPC_MC146818RTC_H
 
 /*
  * Machine dependent access functions for RTC registers.
@@ -33,4 +33,4 @@ outb_p((val),RTC_PORT(1)); \
 })
 
 #endif	/* __KERNEL__ */
-#endif	/* _POWERPC_MC146818RTC_H */
+#endif	/* _ASM_POWERPC_MC146818RTC_H */
diff --git a/include/asm-powerpc/mman.h b/include/asm-powerpc/mman.h
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_MMAN_H
-#define _POWERPC_MMAN_H
+#ifndef _ASM_POWERPC_MMAN_H
+#define _ASM_POWERPC_MMAN_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -49,4 +49,4 @@
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
-#endif /* _POWERPC_MMAN_H */
+#endif	/* _ASM_POWERPC_MMAN_H */
diff --git a/include/asm-powerpc/module.h b/include/asm-powerpc/module.h
--- a/include/asm-powerpc/module.h
+++ b/include/asm-powerpc/module.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_MODULE_H
-#define _POWERPC_MODULE_H
+#ifndef _ASM_POWERPC_MODULE_H
+#define _ASM_POWERPC_MODULE_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -74,4 +74,4 @@ struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
 		   struct exception_table_entry *finish);
 
-#endif /* _POWERPC_MODULE_H */
+#endif	/* _ASM_POWERPC_MODULE_H */
diff --git a/include/asm-powerpc/namei.h b/include/asm-powerpc/namei.h
--- a/include/asm-powerpc/namei.h
+++ b/include/asm-powerpc/namei.h
@@ -1,14 +1,14 @@
+#ifndef _ASM_POWERPC_NAMEI_H
+#define _ASM_POWERPC_NAMEI_H
+
+#ifdef __KERNEL__
+
 /*
- * include/asm-ppc/namei.h
  * Adapted from include/asm-alpha/namei.h
  *
  * Included from fs/namei.c
  */
 
-#ifdef __KERNEL__
-#ifndef __PPC_NAMEI_H
-#define __PPC_NAMEI_H
-
 /* This dummy routine maybe changed to something useful
  * for /usr/gnemul/ emulation stuff.
  * Look at asm-sparc/namei.h for details.
@@ -16,5 +16,5 @@
 
 #define __emul_prefix() NULL
 
-#endif /* __PPC_NAMEI_H */
-#endif /* __KERNEL__ */
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_NAMEI_H */
diff --git a/include/asm-powerpc/poll.h b/include/asm-powerpc/poll.h
--- a/include/asm-powerpc/poll.h
+++ b/include/asm-powerpc/poll.h
@@ -1,5 +1,5 @@
-#ifndef __PPC_POLL_H
-#define __PPC_POLL_H
+#ifndef _ASM_POWERPC_POLL_H
+#define _ASM_POWERPC_POLL_H
 
 #define POLLIN		0x0001
 #define POLLPRI		0x0002
@@ -20,4 +20,4 @@ struct pollfd {
 	short revents;
 };
 
-#endif
+#endif	/* _ASM_POWERPC_POLL_H */
diff --git a/include/asm-powerpc/sembuf.h b/include/asm-powerpc/sembuf.h
--- a/include/asm-powerpc/sembuf.h
+++ b/include/asm-powerpc/sembuf.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_SEMBUF_H
-#define _POWERPC_SEMBUF_H
+#ifndef _ASM_POWERPC_SEMBUF_H
+#define _ASM_POWERPC_SEMBUF_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -33,4 +33,4 @@ struct semid64_ds {
 	unsigned long	__unused4;
 };
 
-#endif /* _POWERPC_SEMBUF_H */
+#endif	/* _ASM_POWERPC_SEMBUF_H */
diff --git a/include/asm-powerpc/shmbuf.h b/include/asm-powerpc/shmbuf.h
--- a/include/asm-powerpc/shmbuf.h
+++ b/include/asm-powerpc/shmbuf.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_SHMBUF_H
-#define _POWERPC_SHMBUF_H
+#ifndef _ASM_POWERPC_SHMBUF_H
+#define _ASM_POWERPC_SHMBUF_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -56,4 +56,4 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
-#endif /* _POWERPC_SHMBUF_H */
+#endif	/* _ASM_POWERPC_SHMBUF_H */
diff --git a/include/asm-powerpc/shmparam.h b/include/asm-powerpc/shmparam.h
--- a/include/asm-powerpc/shmparam.h
+++ b/include/asm-powerpc/shmparam.h
@@ -1,6 +1,6 @@
-#ifndef _PPC_SHMPARAM_H
-#define _PPC_SHMPARAM_H
+#ifndef _ASM_POWERPC_SHMPARAM_H
+#define _ASM_POWERPC_SHMPARAM_H
 
 #define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
 
-#endif /* _PPC_SHMPARAM_H */
+#endif	/* _ASM_POWERPC_SHMPARAM_H */
diff --git a/include/asm-powerpc/siginfo.h b/include/asm-powerpc/siginfo.h
--- a/include/asm-powerpc/siginfo.h
+++ b/include/asm-powerpc/siginfo.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_SIGINFO_H
-#define _POWERPC_SIGINFO_H
+#ifndef _ASM_POWERPC_SIGINFO_H
+#define _ASM_POWERPC_SIGINFO_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -15,4 +15,4 @@
 
 #include <asm-generic/siginfo.h>
 
-#endif /* _POWERPC_SIGINFO_H */
+#endif	/* _ASM_POWERPC_SIGINFO_H */
diff --git a/include/asm-powerpc/socket.h b/include/asm-powerpc/socket.h
--- a/include/asm-powerpc/socket.h
+++ b/include/asm-powerpc/socket.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_SOCKET_H
-#define _POWERPC_SOCKET_H
+#ifndef _ASM_POWERPC_SOCKET_H
+#define _ASM_POWERPC_SOCKET_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -56,4 +56,4 @@
 
 #define SO_PEERSEC		31
 
-#endif /* _POWERPC_SOCKET_H */
+#endif	/* _ASM_POWERPC_SOCKET_H */
diff --git a/include/asm-powerpc/sockios.h b/include/asm-powerpc/sockios.h
--- a/include/asm-powerpc/sockios.h
+++ b/include/asm-powerpc/sockios.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_SOCKIOS_H
-#define _POWERPC_SOCKIOS_H
+#ifndef _ASM_POWERPC_SOCKIOS_H
+#define _ASM_POWERPC_SOCKIOS_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -16,4 +16,4 @@
 #define SIOCATMARK	0x8905
 #define SIOCGSTAMP	0x8906		/* Get stamp */
 
-#endif /* _POWERPC_SOCKIOS_H */
+#endif	/* _ASM_POWERPC_SOCKIOS_H */
diff --git a/include/asm-powerpc/string.h b/include/asm-powerpc/string.h
--- a/include/asm-powerpc/string.h
+++ b/include/asm-powerpc/string.h
@@ -1,5 +1,5 @@
-#ifndef _PPC_STRING_H_
-#define _PPC_STRING_H_
+#ifndef _ASM_POWERPC_STRING_H
+#define _ASM_POWERPC_STRING_H
 
 #ifdef __KERNEL__
 
@@ -29,4 +29,4 @@ extern void * memchr(const void *,int,__
 
 #endif /* __KERNEL__ */
 
-#endif
+#endif	/* _ASM_POWERPC_STRING_H */
diff --git a/include/asm-powerpc/termbits.h b/include/asm-powerpc/termbits.h
--- a/include/asm-powerpc/termbits.h
+++ b/include/asm-powerpc/termbits.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_TERMBITS_H
-#define _POWERPC_TERMBITS_H
+#ifndef _ASM_POWERPC_TERMBITS_H
+#define _ASM_POWERPC_TERMBITS_H
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -188,4 +188,4 @@ struct termios {
 #define	TCSADRAIN	1
 #define	TCSAFLUSH	2
 
-#endif /* _POWERPC_TERMBITS_H */
+#endif	/* _ASM_POWERPC_TERMBITS_H */
diff --git a/include/asm-powerpc/termios.h b/include/asm-powerpc/termios.h
--- a/include/asm-powerpc/termios.h
+++ b/include/asm-powerpc/termios.h
@@ -1,5 +1,5 @@
-#ifndef _POWERPC_TERMIOS_H
-#define _POWERPC_TERMIOS_H
+#ifndef _ASM_POWERPC_TERMIOS_H
+#define _ASM_POWERPC_TERMIOS_H
 
 /*
  * Liberally adapted from alpha/termios.h.  In particular, the c_cc[]
@@ -233,4 +233,4 @@ struct termio {
 
 #endif	/* __KERNEL__ */
 
-#endif	/* _POWERPC_TERMIOS_H */
+#endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/include/asm-powerpc/unaligned.h b/include/asm-powerpc/unaligned.h
--- a/include/asm-powerpc/unaligned.h
+++ b/include/asm-powerpc/unaligned.h
@@ -1,6 +1,7 @@
+#ifndef _ASM_POWERPC_UNALIGNED_H
+#define _ASM_POWERPC_UNALIGNED_H
+
 #ifdef __KERNEL__
-#ifndef __PPC_UNALIGNED_H
-#define __PPC_UNALIGNED_H
 
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
@@ -14,5 +15,5 @@
 
 #define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
 
-#endif
-#endif /* __KERNEL__ */
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_UNALIGNED_H */
