Return-Path: <weiyi.huang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id 083E3DDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 23:41:26 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id j2so2160757tid.13
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 05:41:25 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH 1/3] powerpc: remove duplicated #include's
Date: Tue, 31 Mar 2009 20:41:18 +0800
Message-Id: <1238503278-3876-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove duplicated #include's in
  - arch/powerpc/include/asm/ps3fb.h 
  - arch/powerpc/kernel/setup-common.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/powerpc/include/asm/ps3fb.h   |    1 -
 arch/powerpc/kernel/setup-common.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3fb.h b/arch/powerpc/include/asm/ps3fb.h
index 90dbefb..e7233a8 100644
--- a/arch/powerpc/include/asm/ps3fb.h
+++ b/arch/powerpc/include/asm/ps3fb.h
@@ -21,7 +21,6 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
-#include <linux/types.h>
 
 /* ioctl */
 #define PS3FB_IOCTL_SETMODE       _IOW('r',  1, int) /* set video mode */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9774f9f..02fed27 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -36,7 +36,6 @@
 #include <linux/percpu.h>
 #include <linux/lmb.h>
 #include <linux/of_platform.h>
-#include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
-- 
1.6.0.4
