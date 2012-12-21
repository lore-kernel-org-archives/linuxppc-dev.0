Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/7] powerpc: Add DAWR/X SPR number definitions
Date: Fri, 21 Dec 2012 11:06:43 +1100
Message-Id: <1356048405-20560-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1356048405-20560-1-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index ce7b50e..6cae32d 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -222,6 +222,11 @@
 #define   CTRL_CT1	0x40000000	/* thread 1 */
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
+#define SPRN_DAWR	0xB4
+#define SPRN_DAWRX	0xBC
+#define   DAWRX_USER	(1UL << 0)
+#define   DAWRX_KERNEL	(1UL << 1)
+#define   DAWRX_HYP	(1UL << 2)
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define   DABR_DATA_WRITE	(1UL << 1)
-- 
1.7.10.4
