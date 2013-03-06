Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: Add HFSCR SPR definitions
Date: Wed,  6 Mar 2013 13:15:13 +1100
Message-Id: <1362536114-9658-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1362536114-9658-1-git-send-email-mikey@neuling.org>
References: <1362536114-9658-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add SPR number and bit definitions for the HFSCR (Hypervisor Facility Status
and Control Register).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c9c67fc..4ae2d44 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -268,6 +268,12 @@
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
 #define   FSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
 #define   FSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
+#define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
+#define   HFSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
+#define   HFSCR_TM	(1 << (63-58)) /* Enable Transactional Memory */
+#define   HFSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
+#define   HFSCR_VECVSX	(1 << (63-62)) /* Enable VMX/VSX  */
+#define   HFSCR_FP	(1 << (63-63)) /* Enable Floating Point */
 #define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
 #define   LPCR_VPM0	(1ul << (63-0))
-- 
1.7.10.4
