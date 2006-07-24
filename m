Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57CAF679E1
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:00:27 +1000 (EST)
Date: Mon, 24 Jul 2006 09:00:22 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] enable mac partition label per default on pmac
Message-ID: <20060724070022.GA32295@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Enable mac partition table support per default also for a powermac config.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc2/fs/partitions/Kconfig
===================================================================
--- linux-2.6.18-rc2.orig/fs/partitions/Kconfig
+++ linux-2.6.18-rc2/fs/partitions/Kconfig
@@ -99,7 +99,7 @@ config IBM_PARTITION
 
 config MAC_PARTITION
 	bool "Macintosh partition map support" if PARTITION_ADVANCED
-	default y if MAC
+	default y if (MAC || PPC_PMAC)
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on a Macintosh.
