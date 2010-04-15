Return-Path: <geoff@infradead.org>
Message-ID: <4BC764E6.40002@infradead.org>
Date: Thu, 15 Apr 2010 12:11:34 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] ps3: Update platform maintainer
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the PS3 entries in the MAINTAINERS file.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4482,17 +4482,17 @@ S:	Maintained
 F:	drivers/ata/sata_promise.*
 
 PS3 NETWORK SUPPORT
-M:	Geoff Levand <geoffrey.levand@am.sony.com>
+M:	Geoff Levand <geoff@infradead.org>
 L:	netdev@vger.kernel.org
 L:	cbe-oss-dev@ozlabs.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ps3_gelic_net.*
 
 PS3 PLATFORM SUPPORT
-M:	Geoff Levand <geoffrey.levand@am.sony.com>
+M:	Geoff Levand <geoff@infradead.org>
 L:	linuxppc-dev@ozlabs.org
 L:	cbe-oss-dev@ozlabs.org
-S:	Supported
+S:	Maintained
 F:	arch/powerpc/boot/ps3*
 F:	arch/powerpc/include/asm/lv1call.h
 F:	arch/powerpc/include/asm/ps3*.h
