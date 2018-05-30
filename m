Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wxFZ0qTrzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 02:41:53 +1000 (AEST)
Message-Id: <a30ae52fdd0b611c6e90942f772042fadc67f30a.1527697995.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 3/8] powerpc: remove superflous inclusions of asm-compat.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:50 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc-opcode.h doesn't need asm-compat.h
neither does dt_cpu_ftrs.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h       | 1 -
 arch/powerpc/include/asm/feature-fixups.h | 2 ++
 arch/powerpc/include/asm/ppc-opcode.h     | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 66fcab13c8b4..7518dafa7cd4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/types.h>
-#include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index a9b64df34e2a..ecfdf9d3d145 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_POWERPC_FEATURE_FIXUPS_H
 #define __ASM_POWERPC_FEATURE_FIXUPS_H
 
+#include <asm/asm-compat.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 4436887bc415..ab12fac26f5b 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -13,7 +13,6 @@
 #define _ASM_POWERPC_PPC_OPCODE_H
 
 #include <linux/stringify.h>
-#include <asm/asm-compat.h>
 
 #define	__REG_R0	0
 #define	__REG_R1	1
-- 
2.13.3
