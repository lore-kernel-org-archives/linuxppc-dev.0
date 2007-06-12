Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F7ABDDE49
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:40 +1000 (EST)
Message-ID: <466EEBDB.9050906@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 22/30] Powerpc: Output params value in early_init_devtree
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a printout of the params value to early_init_devtree.
This value is handy to have for comparison when debugging the
bootwrapper code.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/kernel/prom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1005,7 +1005,7 @@ static void __init early_reserve_mem(voi
 
 void __init early_init_devtree(void *params)
 {
-	DBG(" -> early_init_devtree()\n");
+	DBG(" -> early_init_devtree(%p)\n", params);
 
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;

-- 
