Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4F7BDE1BA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 05:03:56 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m9KI3kTa011137
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 13:03:46 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove Kconfig support for PPC_MERGE
Date: Mon, 20 Oct 2008 13:03:46 -0500
Message-Id: <1224525826-17049-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are no users of PPC_MERGE in tree so we can get rid of it.
It was a hold over from the arch/ppc days.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9391199..369d93e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -19,9 +19,6 @@ config WORD_SIZE
 	default 64 if PPC64
 	default 32 if !PPC64
 
-config PPC_MERGE
-	def_bool y
-
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT
 
-- 
1.5.5.1
