Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rblzx3JFdzDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 03:43:25 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <trivial@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/fadump: trivial fix of spelling mistake,
 clean up message
Date: Fri, 24 Jun 2016 18:43:00 +0100
Message-Id: <1466790180-18256-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake "rgistration" and minor clean up
of the printk error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/kernel/fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3cb3b02a..0358f5b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1010,7 +1010,7 @@ static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
 
 	if (rc) {
 		printk(KERN_ERR "Failed to invalidate firmware-assisted dump "
-			"rgistration. unexpected error(%d).\n", rc);
+			"registration. Unexpected error (%d).\n", rc);
 		return rc;
 	}
 	fw_dump.dump_active = 0;
-- 
2.8.1
