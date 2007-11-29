Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id A9F72DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:46:18 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2140057uge
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:46:17 -0800 (PST)
Date: Thu, 29 Nov 2007 22:46:54 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] PPC cleanup: powermac - do use for_each macro
Message-ID: <20071129194654.GF12123@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/platforms/powermac/low_i2c.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da2007e..864fbf4 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -585,8 +585,7 @@ static void __init kw_i2c_probe(void)
 	struct device_node *np, *child, *parent;
 
 	/* Probe keywest-i2c busses */
-	for (np = NULL;
-	     (np = of_find_compatible_node(np, "i2c","keywest-i2c")) != NULL;){
+	for_each_compatible_node(np, "i2c","keywest-i2c") {
 		struct pmac_i2c_host_kw *host;
 		int multibus, chans, i;
 
-- 
1.5.3.5
