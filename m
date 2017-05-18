Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4QX6DHyzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:40:52 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	mchehab@kernel.org,
	linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/3] EDAC: mv64x60: remove unused variable
Date: Thu, 18 May 2017 20:31:33 +1200
Message-Id: <20170518083135.28048-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
References: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/edac/mv64x60_edac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 14b7e7b71eaa..454e1e26ee7c 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -853,8 +853,6 @@ static struct platform_driver * const drivers[] = {
 
 static int __init mv64x60_edac_init(void)
 {
-	int ret = 0;
-
 	printk(KERN_INFO "Marvell MV64x60 EDAC driver " MV64x60_REVISION "\n");
 	printk(KERN_INFO "\t(C) 2006-2007 MontaVista Software\n");
 	/* make sure error reporting method is sane */
-- 
2.11.0.24.ge6920cf
