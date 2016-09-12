Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXkDg1k6ZzDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:14:11 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>,
 Kevin Hao <haokexin@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: add missing \n at end of printk warning message
Date: Mon, 12 Sep 2016 11:12:24 +0100
Message-Id: <20160912101224.24877-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

The message is missing a \n, add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 448685f..b532dd9 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -137,7 +137,7 @@ void __init MMU_init(void)
 	if (memblock.memory.cnt > 1) {
 #ifndef CONFIG_WII
 		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
-		printk(KERN_WARNING "Only using first contiguous memory region");
+		printk(KERN_WARNING "Only using first contiguous memory region\n");
 #else
 		wii_memory_fixups();
 #endif
-- 
2.9.3
