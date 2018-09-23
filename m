Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42J0FG0708zF3JB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 18:02:56 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Al Viro
 <viro@zeniv.linux.org.uk>, Paul Burton <paul.burton@mips.com>, Sinan Kaya
 <okaya@codeaurora.org>, Mathieu Malaterre <malat@debian.org>, Andrew Morton
 <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "Mike
 Rapoport" <rppt@linux.vnet.ibm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>
CC: YueHaibing <yuehaibing@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc: Remove duplicated include from pci_32.c
Date: Sun, 23 Sep 2018 08:12:08 +0000
Message-ID: <1537690328-77353-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/kernel/pci_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d63be12..274bd14 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -17,7 +17,6 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <linux/syscalls.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
