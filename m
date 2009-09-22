Return-Path: <jaswinder@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFCFCB7B68
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 00:45:18 +1000 (EST)
Subject: [PATCH] POWERPC: includecheck fix: mm, tlb_low_64e.S
From: Jaswinder Singh Rajput <jaswinder@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 19:15:05 +0530
Message-Id: <1253627105.3784.20.camel@ht.satnam>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


fix the following 'make includecheck' warning:

  arch/powerpc/mm/tlb_low_64e.S: asm/reg.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/powerpc/mm/tlb_low_64e.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index ef1cccf..f288279 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -18,7 +18,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 #include <asm/pgtable.h>
-#include <asm/reg.h>
 #include <asm/exception-64e.h>
 #include <asm/ppc-opcode.h>
 
-- 
1.6.0.6
