Return-Path: <B45475@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 900912C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 17:54:08 +1100 (EST)
Received: from mail109-co1 (localhost [127.0.0.1])	by
 mail109-co1-R.bigfish.com (Postfix) with ESMTP id F3B8CD601FB	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 06:54:03 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.248])	by
 mail109-co1.bigfish.com (Postfix) with ESMTP id 7CB35300057	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 06:54:01 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/p1010rdb:add P1010RDB-PB platform support
Date: Mon, 14 Oct 2013 14:46:13 +0800
Message-ID: <1381733174-17384-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P1010RDB-PB is similar to P1010RDB(P1010RDB-PA).
So, P1010RDB-PB use the same platform file as P1010RDB.
Then Add support for P1010RDB-PB platform.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/platforms/85xx/p1010rdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 0252961..d6a3dd3 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -66,6 +66,8 @@ static int __init p1010_rdb_probe(void)
 
 	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB"))
 		return 1;
+	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB-PB"))
+		return 1;
 	return 0;
 }
 
-- 
1.8.0
