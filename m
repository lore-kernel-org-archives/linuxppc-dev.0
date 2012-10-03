Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH] powerpc: Add asm/debug.h to get powerpc_debugfs_root
Date: Wed,  3 Oct 2012 11:52:41 +1000
Message-Id: <1349229161-6380-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the "Disintegrate asm/system.h for PowerPC"
(ae3a197e3d0bfe3f4bf1693723e82dc018c096f3) This has been failing when
DEBUG is #defined.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/kernel/prom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 8dfd43f..3bd6c84 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -57,6 +57,7 @@
 
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/debug.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
-- 
1.7.7.6
