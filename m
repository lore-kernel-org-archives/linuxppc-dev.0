Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 6637E1A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:51 +1000 (AEST)
Message-Id: <3034aa1a6e3b9e1a84765fb9321f7782768bbb65.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/25] powerpc/8xx: CONFIG_PIN_TLB unneeded for
 CONFIG_PPC_EARLY_DEBUG_CPM
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IMMR is now mapped at 0xff000000 by page tables so it is not
anymore necessary to PIN TLBs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 70168a2..452b086 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -220,7 +220,6 @@ config PPC_EARLY_DEBUG_40x
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
 	depends on SERIAL_CPM
-	select PIN_TLB if PPC_8xx
 	help
 	  Select this to enable early debugging for Freescale chips
 	  using a CPM-based serial port.  This assumes that the bootwrapper
-- 
2.1.0
