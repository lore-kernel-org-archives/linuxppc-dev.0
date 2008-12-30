Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6C5DDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:32:26 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mBUHWLMR006815
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 11:32:22 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Enable SMP support
Date: Tue, 30 Dec 2008 11:32:20 -0600
Message-Id: <1230658341-20124-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 3d0c776..e868b5c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -231,7 +231,7 @@ config VIRT_CPU_ACCOUNTING
 	  If in doubt, say Y here.
 
 config SMP
-	depends on PPC_STD_MMU
+	depends on PPC_STD_MMU || FSL_BOOKE
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-- 
1.5.6.5
