Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A61181007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 08:50:39 +1100 (EST)
Date: Thu, 24 Mar 2011 16:50:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/booke: Correct the SPRN_MAS5 definition.
Message-ID: <20110324215026.GA9586@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Varun Sethi <Varun.Sethi@freescale.com>

339 is the SPR number for MAS5 documented by Power ISA 2.06, and
implemented by e500mc.  It is not yet used anywhere in the kernel,
so nothing should be relying on the wrong number.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 86ad812..3b1a9b7 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -110,7 +110,7 @@
 #define SPRN_MAS2	0x272	/* MMU Assist Register 2 */
 #define SPRN_MAS3	0x273	/* MMU Assist Register 3 */
 #define SPRN_MAS4	0x274	/* MMU Assist Register 4 */
-#define SPRN_MAS5	0x275	/* MMU Assist Register 5 */
+#define SPRN_MAS5	0x153	/* MMU Assist Register 5 */
 #define SPRN_MAS6	0x276	/* MMU Assist Register 6 */
 #define SPRN_PID1	0x279	/* Process ID Register 1 */
 #define SPRN_PID2	0x27A	/* Process ID Register 2 */
-- 
1.7.1
