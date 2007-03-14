Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 885E5DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 20:16:45 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Message-Id: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 14 Mar 2007 09:16:34 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It's bool and it depends on IDE => should depend on IDE=y

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/ide/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 5d134bb..3f76987 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -802,7 +802,7 @@ config BLK_DEV_IDEDMA_PMAC
 
 config BLK_DEV_IDE_CELLEB
 	bool "Toshiba's Cell Reference Set IDE support"
-	depends on PPC_CELLEB
+	depends on PPC_CELLEB && IDE=y
 	help
 	  This driver provides support for the built-in IDE controller on
 	  Toshiba Cell Reference Board.
-- 
1.5.0-rc2.GIT
