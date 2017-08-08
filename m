Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXxJ3kXbzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:59:00 +1000 (AEST)
Message-Id: <f324c47296dee3a6779480434425c592aeb6e277.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 09/12] powerpc/8xx: remove CONFIG_8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two config options exist to define powerpc MPC8xx:
* CONFIG_PPC_8xx
* CONFIG_8xx

arch/powerpc/platforms/Kconfig.cputype has contained the following
comment about CONFIG_8xx item for some years:
"# this is temp to handle compat with arch=ppc"

There is no more users of CONFIG_8xx, so remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 395593ef580c..13663efc1d31 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -32,7 +32,6 @@ config PPC_85xx
 config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
-	select 8xx
 	select PPC_LIB_RHEAP
 	select SYS_SUPPORTS_HUGETLBFS
 
@@ -149,10 +148,6 @@ config 6xx
 	depends on PPC32 && PPC_BOOK3S
 	select PPC_HAVE_PMU_SUPPORT
 
-# this is temp to handle compat with arch=ppc
-config 8xx
-	bool
-
 config E500
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-- 
2.13.3
