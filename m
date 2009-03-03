Return-Path: <geoff@hera.kernel.org>
Message-Id: <20090303183304.870675755@am.sony.com>>
References: <20090303183304.791485071@am.sony.com>>
In-Reply-To: <20090303183304.791485071@am.sony.com>>
Date: Tue, 03 Mar 2009 10:33:05 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 1/3] powerpc: Add missing DABR flags
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc 64 bit architecture defines three flags for the
DABR (Data Address Breakpoint Register).  Add definitions
for the currently missing DABR_DATA_WRITE and DABR_DATA_READ
flags to the powerpc reg.h file.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/reg.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -155,6 +155,8 @@
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
 #define   DABR_TRANSLATION	(1UL << 2)
+#define   DABR_DATA_WRITE	(1UL << 1)
+#define   DABR_DATA_READ	(1UL << 0)
 #define SPRN_DABR2	0x13D	/* e300 */
 #define SPRN_DABRX	0x3F7	/* Data Address Breakpoint Register Extension */
 #define   DABRX_USER	(1UL << 0)

-- 
