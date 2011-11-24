Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3103D1007E6
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 18:08:54 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAO78o0G002009
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 01:08:51 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/85xx: Renamed mpc85xx_common.c to common.c
Date: Thu, 24 Nov 2011 01:08:47 -0600
Message-Id: <1322118527-14348-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1322118527-14348-1-git-send-email-galak@kernel.crashing.org>
References: <1322118527-14348-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The file name is already scoped by the directory its in.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Makefile               |    2 +-
 .../platforms/85xx/{mpc85xx_common.c => common.c}  |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/powerpc/platforms/85xx/{mpc85xx_common.c => common.c} (100%)

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index b6beec8..9cb2d43 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,7 +3,7 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 
-obj-y += mpc85xx_common.o
+obj-y += common.o
 
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/common.c
similarity index 100%
rename from arch/powerpc/platforms/85xx/mpc85xx_common.c
rename to arch/powerpc/platforms/85xx/common.c
-- 
1.7.3.4
