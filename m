Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 858FCDE059
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:09:10 +1000 (EST)
Message-ID: <46730D56.8010008@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 22/33] powerpc: Output params value in early_init_devtree
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
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
