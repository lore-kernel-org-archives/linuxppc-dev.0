Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 7152CDDE11
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:54:24 +1100 (EST)
Message-ID: <49371BAF.7010400@am.sony.com>
Date: Wed, 3 Dec 2008 15:52:15 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/3] powerpc/ps3: Quiet dmesg output
References: <49371ACA.9040800@am.sony.com>
In-Reply-To: <49371ACA.9040800@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the debug message in dma_sb_region_create() from
pr_info() to DBG() to quiet the dmesg output.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/mm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -649,7 +649,7 @@ static int dma_sb_region_create(struct p
 {
 	int result;
 
-	pr_info(" -> %s:%d:\n", __func__, __LINE__);
+	DBG(" -> %s:%d:\n", __func__, __LINE__);
 
 	BUG_ON(!r);
 

-- 
