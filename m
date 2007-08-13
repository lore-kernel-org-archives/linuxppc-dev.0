Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46C0DA2B.6080407@am.sony.com>
Date: Mon, 13 Aug 2007 15:24:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: joe@perches.com
Subject: Re: [PATCH] [392/2many] MAINTAINERS - PS3 PLATFORM SUPPORT
References: <46bffb71.JWcVvIR5pg3biTEh%joe@perches.com>
In-Reply-To: <46bffb71.JWcVvIR5pg3biTEh%joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: joe@perches.com

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
I also maintain the file include/asm-powerpc/lv1call.h.
This updated patch adds that file.

-Geoff

 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3015,6 +3015,13 @@ M:	geoffrey.levand@am.sony.com
 L:	linuxppc-dev@ozlabs.org
 L:	cbe-oss-dev@ozlabs.org
 S:	Supported
+F:	arch/powerpc/boot/ps3*
+F:	arch/powerpc/platforms/ps3/
+F:	drivers/*/ps3*
+F:	drivers/ps3/
+F:	drivers/usb/host/*ps3.c
+F:	include/asm-powerpc/ps3*
+F:	include/asm-powerpc/lv1call.h
 
 PVRUSB2 VIDEO4LINUX DRIVER
 P:	Mike Isely
