Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 62A1EDDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:34:38 +1000 (EST)
Date: Sun, 12 Aug 2007 23:34:25 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, geoffrey.levand@am.sony.com,
	cbe-oss-dev@ozlabs.org, akpm@linux-foundation.org
Subject: [PATCH] [392/2many] MAINTAINERS - PS3 PLATFORM SUPPORT
Message-ID: <46bffb71.JWcVvIR5pg3biTEh%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fe48a0..62b6ede 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3746,6 +3746,12 @@ M:	geoffrey.levand@am.sony.com
 L:	linuxppc-dev@ozlabs.org
 L:	cbe-oss-dev@ozlabs.org
 S:	Supported
+F:	arch/powerpc/boot/ps3*
+F:	arch/powerpc/platforms/ps3/
+F:	drivers/*/ps3*
+F:	drivers/ps3/
+F:	drivers/usb/host/*ps3.c
+F:	include/asm-powerpc/ps3*
 
 PVRUSB2 VIDEO4LINUX DRIVER
 P:	Mike Isely
