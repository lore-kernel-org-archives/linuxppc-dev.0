Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203522.545166000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:10 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@osdl.org>
Subject: [patch 10/13] add sys_unshare to syscalls.h
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All architecture independent system calls should be declared
in syscalls.h, add the one that is missing.

To: Andrew Morton <akpm@osdl.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

This patch is not powerpc-specific in principle, the reason
for including it in my cell updates is that my next patch
depends on it.

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d73501b..72de104 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -568,5 +568,6 @@ asmlinkage long compat_sys_newfstatat(un
 				      int flag);
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
+asmlinkage long sys_unshare(unsigned long unshare_flags);
 
 #endif

--
