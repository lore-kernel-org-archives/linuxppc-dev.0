Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Sl12XPzF36d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:18:47 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
 <linux-kernel@vger.kernel.org>
Message-Id: <348ad9ee1da7853b59e3ffeda38b652470ec4515.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 6/7] macintosh/via-macii, macintosh/adb-iop: Modernize printk
 calls
Date: Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing severity level to log messages.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c   | 2 +-
 drivers/macintosh/via-macii.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca623e6446e4..3a1e995ecc0e 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -208,7 +208,7 @@ int adb_iop_probe(void)
 
 int adb_iop_init(void)
 {
-	printk("adb: IOP ISM driver v0.4 for Unified ADB.\n");
+	pr_info("adb: IOP ISM driver v0.4 for Unified ADB\n");
 	iop_listen(ADB_IOP, ADB_CHAN, adb_iop_listen, "ADB");
 	return 0;
 }
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 6ed9ac91aca1..a38f57ba50cb 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -127,7 +127,7 @@ static int macii_probe(void)
 
 	via = via1;
 
-	printk("adb: Mac II ADB Driver v1.0 for Unified ADB\n");
+	pr_info("adb: Mac II ADB Driver v1.0 for Unified ADB\n");
 	return 0;
 }
 
-- 
2.16.4
