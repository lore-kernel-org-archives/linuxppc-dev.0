Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DEA1DE01F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/22] [PPC] Add clrbits8 and setbits8.
Date: Thu, 13 Sep 2007 16:07:54 -0500
Message-Id: <11897177052448-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897177042582-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

These I/O accessors will be used in code under drivers/,
which is expected to still work in arch/ppc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-ppc/io.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 95d5904..f776c49 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -553,4 +553,7 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
 #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
 
+#define setbits8(_addr, _v) out_8((_addr), in_8(_addr) |  (_v))
+#define clrbits8(_addr, _v) out_8((_addr), in_8(_addr) & ~(_v))
+
 #endif /* __KERNEL__ */
-- 
1.5.2.4
