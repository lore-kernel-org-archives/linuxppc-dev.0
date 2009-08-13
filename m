Return-Path: <Paul.Gortmaker@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: derive COMMAND_LINE_SIZE from asm-generic
Date: Thu, 13 Aug 2009 15:37:04 -0400
Message-Id: <1250192224-22772-1-git-send-email-paul.gortmaker@windriver.com>
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The default COMMAND_LINE_SIZE in asm-generic is 512, so the
net effect of this change is nil, aside from the cleanup
factor.  See also commit 2b74b8569.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/include/asm/setup.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 817fac0..dae1934 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#define COMMAND_LINE_SIZE	512
+#include <asm-generic/setup.h>
 
 #endif	/* _ASM_POWERPC_SETUP_H */
-- 
1.6.3.3
