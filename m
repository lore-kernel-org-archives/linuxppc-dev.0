Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wxFc18n8zDr69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 02:41:55 +1000 (AEST)
Message-Id: <25e6eaa136ed6a0e0be2c13701e57d2e3cc85cbb.1527697995.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 4/8] powerpc: remove superflous inclusions of
 asm/feature-fixups.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:52 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

files not using feature fixup don't need asm/feature-fixups.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h | 1 -
 arch/powerpc/include/asm/firmware.h | 1 -
 arch/powerpc/include/asm/mmu.h      | 1 -
 arch/powerpc/include/asm/reg.h      | 1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 7518dafa7cd4..e99905274a77 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/types.h>
-#include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 535add3f7791..59ae44cf0bb8 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -15,7 +15,6 @@
 #ifdef __KERNEL__
 
 #include <asm/asm-compat.h>
-#include <asm/feature-fixups.h>
 
 /* firmware feature bitmask values */
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 61d15ce92278..61d0d2d69583 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 #include <asm/asm-compat.h>
-#include <asm/feature-fixups.h>
 
 /*
  * MMU features bit definitions
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cb0f272ce123..a7b8860ed896 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -13,6 +13,7 @@
 
 #include <linux/stringify.h>
 #include <asm/cputable.h>
+#include <asm/feature-fixups.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-- 
2.13.3
