Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95BE7DDED8
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 06:37:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n36KaxGO026706
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2009 15:37:00 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix tlbilx opcode
Date: Mon,  6 Apr 2009 15:36:59 -0500
Message-Id: <1239050219-4477-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The tlbilx opcode was not matching the Power ISA 2.06 arch spec.
The old opcode was an early suggested opcode that changed during the
2.06 architecture process.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index f4a4db8..640ccbb 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -43,7 +43,7 @@
 
 #define PPC_INST_STSWI			0x7c0005aa
 #define PPC_INST_STSWX			0x7c00052a
-#define PPC_INST_TLBILX			0x7c000626
+#define PPC_INST_TLBILX			0x7c000024
 #define PPC_INST_WAIT			0x7c00007c
 
 /* macros to insert fields into opcodes */
-- 
1.6.0.6
