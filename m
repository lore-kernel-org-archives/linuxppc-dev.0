Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW6L71kpTzDr2k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 17:14:23 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix two CONFIG_8xx left behind
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170814071419.6994F678A3@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Mon, 14 Aug 2017 09:14:19 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 968159c0031ac ("powerpc/8xx: Getting rid of remaining
use of CONFIG_8xx") removed all but 2 references to 8xx in
Kconfigs.

This patch removes the two remaining ones.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig               | 2 +-
 arch/powerpc/platforms/8xx/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c8334a5b0eb7..2a290561e851 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1176,7 +1176,7 @@ config CONSISTENT_SIZE
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
-	depends on ADVANCED_OPTIONS && 8xx
+	depends on ADVANCED_OPTIONS && PPC_8xx
 
 config PIN_TLB_IMMR
 	bool "Pinned TLB for IMMR"
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index d3f664f5166b..536b0c5d5ce3 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -91,7 +91,7 @@ endmenu
 #
 
 menu "MPC8xx CPM Options"
-	depends on 8xx
+	depends on PPC_8xx
 
 # This doesn't really belong here, but it is convenient to ask
 # 8xx specific questions.
-- 
2.13.3
