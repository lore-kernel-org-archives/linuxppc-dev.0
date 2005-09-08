Return-Path: <jdl@jdl.com>
From: jdl@freescale.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Thu, 08 Sep 2005 14:05:49 -0500
Message-Id: <E1EDRiX-00072b-Cp@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH Fix __power64__ typos that should be __powerpc64__
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix __power64__ typo that should be __powerpc64__ instead.

 include/asm-powerpc/shmbuf.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


diff --git a/include/asm-powerpc/shmbuf.h b/include/asm-powerpc/shmbuf.h
--- a/include/asm-powerpc/shmbuf.h
+++ b/include/asm-powerpc/shmbuf.h
@@ -21,19 +21,19 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#ifndef __power64__
+#ifndef __powerpc64__
 	unsigned long		__unused1;
 #endif
 	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __power64__
+#ifndef __powerpc64__
 	unsigned long		__unused2;
 #endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __power64__
+#ifndef __powerpc64__
 	unsigned long		__unused3;
 #endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __power64__
+#ifndef __powerpc64__
 	unsigned long		__unused4;
 #endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
