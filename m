Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix compile error with 85xx/p1022_ds.c
Date: Mon, 12 Dec 2011 09:49:14 +1100
Message-ID: <22284.1323643754@neuling.org>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current linux-next compiled with mpc85xx_defconfig causes this:
 arch/powerpc/platforms/85xx/p1022_ds.c:341:14: error: 'udbg_progress' undeclared here (not in a function)

Add include to fix this.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index bb3d84f..b0984ad 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -25,6 +25,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include <asm/udbg.h>
 #include <asm/fsl_guts.h>
 #include "smp.h"
 
