Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 30C552C0222
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:39 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdN013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:37 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] powerpc/powernv: Enable detection of legacy UARTs
Date: Mon, 15 Jul 2013 13:03:15 +1000
Message-Id: <1373857395-2084-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Legacy UARTs can exist on PowerNV, memory-mapped ones on PCI
or IO based ones on the LPC bus.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6529587..6fae5eb 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -8,6 +8,7 @@ config PPC_POWERNV
 	select PPC_PCI_CHOICE if EMBEDDED
 	select EPAPR_BOOT
 	select PPC_INDIRECT_PIO
+	select PPC_UDBG_16550
 	default y
 
 config POWERNV_MSI
-- 
1.8.1.2
