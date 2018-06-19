Return-Path: <aaro.koskinen@iki.fi>
Received: from emh07.mail.saunalahti.fi (emh07.mail.saunalahti.fi
 [62.142.5.117])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419L5P08xRzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 07:02:48 +1000 (AEST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] powerpc: enable kernel XZ compression option on BOOK3S_32
Date: Tue, 19 Jun 2018 23:52:30 +0300
Message-Id: <20180619205230.19290-1-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable kernel XZ compression option on BOOK3S_32. Tested on G4 PowerBook.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 67d3125d0610..aa8fe7fcc48e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -25,6 +25,7 @@ choice
 config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
+	select HAVE_KERNEL_XZ
 
 config PPC_85xx
 	bool "Freescale 85xx"
-- 
2.17.0
