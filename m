Return-Path: <weiyi.huang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id EDD26DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 15:56:16 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so511540tib.13
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 22:56:15 -0700 (PDT)
Date: Sat, 23 Aug 2008 13:56:14 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
To: tnt@246tNt.com,
 grant.likely@secretlab.ca
Subject: powerpc/mpc5200: remove unused #include <version.h>
Message-Id: <20080823131253.1274.WEIYI.HUANG@gmail.com>
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

The file(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  arch/powerpc/sysdev/bestcomm/gen_bd.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/arch/powerpc/sysdev/bestcomm/gen_bd.c b/arch/powerpc/sysdev/bestcomm/gen_bd.c
index a3a134c..e0a53e3 100644
--- a/arch/powerpc/sysdev/bestcomm/gen_bd.c
+++ b/arch/powerpc/sysdev/bestcomm/gen_bd.c
@@ -11,7 +11,6 @@
  *
  */

-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
