Return-Path: <a.beregalov@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 7D762DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 20:15:26 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so417150rvb.1
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 03:15:24 -0700 (PDT)
Date: Fri, 17 Apr 2009 14:15:13 +0400
From: Alexander Beregalov <a.beregalov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] macintosh/mediabay should depend on BLOCK
Message-ID: <20090417101513.GA31127@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix this build error
In file included from drivers/macintosh/mediabay.c:21:
include/linux/ide.h:605: error: field 'request_sense_rq' has incomplete type

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/macintosh/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 173cf55..3d90683 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -123,7 +123,7 @@ config PMAC_APM_EMU
 
 config PMAC_MEDIABAY
 	bool "Support PowerBook hotswap media bay"
-	depends on PPC_PMAC && PPC32
+	depends on PPC_PMAC && PPC32 && BLOCK
 	help
 	  This option adds support for older PowerBook's hotswap media bay
 	  that can contains batteries, floppy drives, or IDE devices. PCI
