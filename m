Return-Path: <qiang.zhao@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBD882C016A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 14:13:22 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] powerpc/p1010rdb:add P1010RDB-PB platform support
Date: Thu, 7 Nov 2013 10:29:27 +0800
Message-ID: <1383791369-29324-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org
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
1.8.4
