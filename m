Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb7CZ1gl0zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 03:06:18 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powernv: spelling mistake: "Retrived" -> "Retrieved"
Date: Thu, 23 Jun 2016 18:05:56 +0100
Message-Id: <1466701556-8226-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in pr_debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/powernv/opal-memory-errors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index 00a2943..4495f42 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -44,7 +44,7 @@ static void handle_memory_error_event(struct OpalMemoryErrorData *merr_evt)
 {
 	uint64_t paddr_start, paddr_end;
 
-	pr_debug("%s: Retrived memory error event, type: 0x%x\n",
+	pr_debug("%s: Retrieved memory error event, type: 0x%x\n",
 		  __func__, merr_evt->type);
 	switch (merr_evt->type) {
 	case OPAL_MEM_ERR_TYPE_RESILIENCE:
-- 
2.8.1
