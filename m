Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D891B7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 11:43:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE7ABDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 11:43:58 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n821hsvw031407
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 20:43:54 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/book3e: Add missing page sizes
Date: Tue,  1 Sep 2009 20:43:54 -0500
Message-Id: <1251855834-24320-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add defines for the other page sizes.  Even if HW doesn't support them
we made them use them for hugetlbfs support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pte-book3e.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/pte-book3e.h
index 9800565..b82b9dc 100644
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -20,9 +20,19 @@
 #define _PAGE_BAP_UX	0x000080
 #define _PAGE_PSIZE_MSK	0x000f00
 #define _PAGE_PSIZE_4K	0x000200
+#define _PAGE_PSIZE_8K	0x000300
+#define _PAGE_PSIZE_16K	0x000400
+#define _PAGE_PSIZE_32K	0x000500
 #define _PAGE_PSIZE_64K	0x000600
+#define _PAGE_PSIZE_128K	0x000700
+#define _PAGE_PSIZE_256K	0x000800
+#define _PAGE_PSIZE_512K	0x000900
 #define _PAGE_PSIZE_1M	0x000a00
+#define _PAGE_PSIZE_2M	0x000b00
+#define _PAGE_PSIZE_4M	0x000c00
+#define _PAGE_PSIZE_8M	0x000d00
 #define _PAGE_PSIZE_16M	0x000e00
+#define _PAGE_PSIZE_32M	0x000f00
 #define _PAGE_DIRTY	0x001000 /* C: page changed */
 #define _PAGE_SW0	0x002000
 #define _PAGE_U3	0x004000
-- 
1.6.0.6
