Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26839DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 23:23:49 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7HDNhP0016205
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:23:45 -0500
Date: Fri, 17 Aug 2007 08:24:02 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix 8xx compile failure
Message-ID: <Pine.LNX.4.64.0708170823150.31758@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  CC      arch/powerpc/sysdev/commproc.o
arch/powerpc/sysdev/fsl_soc.c: In function fsl_pcmcia_of_init:
arch/powerpc/sysdev/fsl_soc.c:1109: error: implicit declaration of function of_platform_device_create

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This patch is in the fixes-2.6.23 branch of my git tree

 arch/powerpc/sysdev/fsl_soc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..f6943fc 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -36,6 +36,7 @@
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
+#include <asm/of_platform.h>

 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
-- 
1.5.2.2
