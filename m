Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDDBA1A0212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 01:39:57 +1000 (AEST)
Message-ID: <5602BFEE.7060708@freescale.com>
Date: Wed, 23 Sep 2015 18:06:22 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
CC: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>, Scott Wood
 <scottwood@freescale.com>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH] powerpc/e6500: add TMCFG0 register definition
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The register is not currently used in the base kernel
but will be in a forthcoming kvm patch.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 16547ef..2fef74b 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -742,6 +742,12 @@
 #define MMUBE1_VBE4		0x00000002
 #define MMUBE1_VBE5		0x00000001
 
+#define TMRN_TMCFG0      16	/* Thread Management Configuration Register 0 */
+#define TMRN_TMCFG0_NPRIBITS       0x003f0000 /* Bits of thread priority */
+#define TMRN_TMCFG0_NPRIBITS_SHIFT 16
+#define TMRN_TMCFG0_NATHRD         0x00003f00 /* Number of active threads */
+#define TMRN_TMCFG0_NATHRD_SHIFT   8
+#define TMRN_TMCFG0_NTHRD          0x0000003f /* Number of threads */
 #define TMRN_IMSR0	0x120	/* Initial MSR Register 0 (e6500) */
 #define TMRN_IMSR1	0x121	/* Initial MSR Register 1 (e6500) */
 #define TMRN_INIA0	0x140	/* Next Instruction Address Register 0 */
-- 
1.8.3.1
