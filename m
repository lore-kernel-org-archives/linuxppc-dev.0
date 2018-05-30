Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.ozlabs.org (Postfix) with ESMTP id 40wlLx0FQrzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 19:15:53 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powermac: fix spelling mistake "Usupported" ->
 "Unsupported"
Date: Wed, 30 May 2018 10:15:40 +0100
Message-Id: <20180530091540.10264-1-colin.king@canonical.com>
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

Trivial fix to spelling mistake in bootx_printf message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index ba0964c17620..3b3b0b9b3577 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -519,7 +519,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 			;
 	}
 	if (bi->architecture != BOOT_ARCH_PCI) {
-		bootx_printf(" !!! WARNING - Usupported machine"
+		bootx_printf(" !!! WARNING - Unsupported machine"
 			     " architecture !\n");
 		for (;;)
 			;
-- 
2.17.0
