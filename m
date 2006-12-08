Return-Path: <maynardj@us.ibm.com>
Message-ID: <45799CA2.2090407@us.ibm.com>
Date: Fri, 08 Dec 2006 11:10:58 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [Patch] Add necessary #includes to asm-powerpc/spu.h
Content-Type: multipart/mixed; boundary="------------070906070702000304080305"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070906070702000304080305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070906070702000304080305
Content-Type: text/x-diff;
 name="spu-h-includes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spu-h-includes.patch"

Subject: Add necessary #includes to asm-powerpc/spu.h.

From: Maynard Johnson <maynardj@us.ibm.com>

This patch adds a couple of #includes to asm-powerpc/spu.h to
prevent compilation warnings that can occur when spu.h is
included from a source file where fs.h and notifier.h have
not been included already.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/spu.h	2006-12-04 10:56:17.406636032 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h	2006-12-08 10:38:10.069679312 -0600
@@ -24,6 +24,8 @@
 #define _SPU_H
 #ifdef __KERNEL__
 
+#include <linux/fs.h>
+#include <linux/notifier.h>
 #include <linux/workqueue.h>
 #include <linux/sysdev.h>
 

--------------070906070702000304080305--
