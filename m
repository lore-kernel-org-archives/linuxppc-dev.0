Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB145DDFA6
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:25:33 +1000 (EST)
Date: Wed, 5 Sep 2007 14:25:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/4] ppc: Add clrbits8 and setbits8.
Message-ID: <20070905192523.GA32280@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These I/O accessors will be used in code under drivers/,
which is expected to still work in arch/ppc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
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
1.5.3
