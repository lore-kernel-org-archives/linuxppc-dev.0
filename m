Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 30 Oct 2007 14:55:04 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
Subject: [PATCH] Fix build failure in platforms/celleb/setup.c which
	CONFIG_VIRT_CPU_ACCOUNTING is not defined.
Message-ID: <20071030035504.GW24243@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without this patch I get the following build failure
  CC      arch/powerpc/platforms/celleb/setup.o
arch/powerpc/platforms/celleb/setup.c:151: error: 'generic_calibrate_decr' undeclared here (not in a function)

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/celleb/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index 1769d75..ddfb35a 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -49,6 +49,7 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/irq.h>
+#include <asm/time.h>
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
 #include <asm/of_platform.h>
-- 
1.5.3.4

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
