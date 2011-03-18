Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 74746B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 04:20:21 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -mm] RapidIO,powerpc/85xx: Fix configuration option
Date: Fri, 18 Mar 2011 13:18:55 -0400
Message-Id: <1300468735-1158-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Follows set of patches in -mm tree. Replaces configuration option
missed in previous patches.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 5c518ad..9136111 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -64,7 +64,7 @@ _GLOBAL(__setup_cpu_e500v2)
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500_ivors
-#ifdef CONFIG_RAPIDIO
+#ifdef CONFIG_FSL_RIO
 	/* Ensure that RFXE is set */
 	mfspr	r3,SPRN_HID1
 	oris	r3,r3,HID1_RFXE@h
-- 
1.7.3.1
