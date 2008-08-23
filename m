Return-Path: <weiyi.huang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id 3489DDDFC5
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 15:56:34 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so511540tib.13
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 22:56:33 -0700 (PDT)
Date: Sat, 23 Aug 2008 13:56:32 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
To: grant.likely@secretlab.ca,
 jacmet@sunsite.dk
Subject: [POWERPC] XilinxFB: removed unused #include <version.h>
Message-Id: <20080823133625.128F.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  drivers/video/xilinxfb.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 7b3a842..5da3d24 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -24,7 +24,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
