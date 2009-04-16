Return-Path: <geoff@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81617DE1C7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:27:16 +1000 (EST)
Message-Id: <20090416190536.799342076@am.sony.com>>
References: <20090416190536.540992667@am.sony.com>>
In-Reply-To: <20090416190536.540992667@am.sony.com>>
Date: Thu, 16 Apr 2009 12:05:40 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 4/4] maintainers: Fix PS3 patterns
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Correct the MAINTAINERS file patterns for PS3.  Removes some PS3
patterns that were under 'CELL BROADBAND ENGINE ARCHITECTURE', and
adds missing PS3 sound and RTC driver patterns.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 MAINTAINERS |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1280,12 +1280,9 @@ L:	cbe-oss-dev@ozlabs.org
 W:	http://www.ibm.com/developerworks/power/cell/
 S:	Supported
 F:	arch/powerpc/include/asm/cell*.h
-F:	arch/powerpc/include/asm/lv1call.h
-F:	arch/powerpc/include/asm/ps3*.h
 F:	arch/powerpc/include/asm/spu*.h
 F:	arch/powerpc/oprofile/*cell*
 F:	arch/powerpc/platforms/cell/
-F:	arch/powerpc/platforms/ps3/
 
 CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
 P:	David Vrabel
@@ -4434,7 +4431,9 @@ F:	arch/powerpc/include/asm/ps3*.h
 F:	arch/powerpc/platforms/ps3/
 F:	drivers/*/ps3*
 F:	drivers/ps3/
+F:	drivers/rtc/rtc-ps3.c
 F:	drivers/usb/host/*ps3.c
+F:	sound/ppc/snd_ps3*
 
 PS3VRAM DRIVER
 P:	Jim Paris

-- 
