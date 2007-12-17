Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 6583BDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 06:32:22 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/ppc/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:14 -0800
Message-Id: <1197919875-5288-15-git-send-email-joe@perches.com>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/ppc/syslib/ppc8xx_pic.c |    2 +-
 arch/ppc/syslib/ppc_sys.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/ppc8xx_pic.c b/arch/ppc/syslib/ppc8xx_pic.c
index e8619c7..bce9a75 100644
--- a/arch/ppc/syslib/ppc8xx_pic.c
+++ b/arch/ppc/syslib/ppc8xx_pic.c
@@ -16,7 +16,7 @@ extern int cpm_get_irq(void);
  * the only interrupt controller.  Some boards, like the MBX and
  * Sandpoint have the 8259 as a secondary controller.  Depending
  * upon the processor type, the internal controller can have as
- * few as 16 interrups or as many as 64.  We could use  the
+ * few as 16 interrupts or as many as 64.  We could use  the
  * "clear_bit()" and "set_bit()" functions like other platforms,
  * but they are overkill for us.
  */
diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index 2d48018..837183c 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -185,7 +185,7 @@ void platform_notify_map(const struct platform_notify_dev_map *map,
  */
 
 /*
-   Here we'll replace .name pointers with fixed-lenght strings
+   Here we'll replace .name pointers with fixed-length strings
    Hereby, this should be called *before* any func stuff triggeded.
  */
 void ppc_sys_device_initfunc(void)
-- 
1.5.3.7.949.g2221a6
