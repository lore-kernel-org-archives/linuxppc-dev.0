Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94A591A074F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 13:20:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/cell: Drop cbe-oss-dev mailing list from MAINTAINERS
Date: Fri,  1 May 2015 13:20:25 +1000
Message-Id: <1430450425-21260-1-git-send-email-mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 geoff@infradead.org, jim@jtan.com, Jeremy Kerr <jk@ozlabs.org>,
 cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traffic on the cbe-oss-dev list is more or less non-existent, other than
CC's from linuxppc.

It's seems like we may as well just send everyone to linuxppc and
archive the list.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0d68b2..b8e038ca0d26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2433,7 +2433,6 @@ F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
 CELL BROADBAND ENGINE ARCHITECTURE
 M:	Arnd Bergmann <arnd@arndb.de>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	cbe-oss-dev@lists.ozlabs.org
 W:	http://www.ibm.com/developerworks/power/cell/
 S:	Supported
 F:	arch/powerpc/include/asm/cell*.h
@@ -7824,14 +7823,13 @@ F:	drivers/net/wireless/prism54/
 PS3 NETWORK SUPPORT
 M:	Geoff Levand <geoff@infradead.org>
 L:	netdev@vger.kernel.org
-L:	cbe-oss-dev@lists.ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/net/ethernet/toshiba/ps3_gelic_net.*
 
 PS3 PLATFORM SUPPORT
 M:	Geoff Levand <geoff@infradead.org>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	cbe-oss-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/boot/ps3*
 F:	arch/powerpc/include/asm/lv1call.h
@@ -7845,7 +7843,7 @@ F:	sound/ppc/snd_ps3*
 
 PS3VRAM DRIVER
 M:	Jim Paris <jim@jtan.com>
-L:	cbe-oss-dev@lists.ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/block/ps3vram.c
 
@@ -9321,7 +9319,6 @@ F:	drivers/net/ethernet/toshiba/spider_net*
 SPU FILE SYSTEM
 M:	Jeremy Kerr <jk@ozlabs.org>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	cbe-oss-dev@lists.ozlabs.org
 W:	http://www.ibm.com/developerworks/power/cell/
 S:	Supported
 F:	Documentation/filesystems/spufs.txt
-- 
2.1.0
