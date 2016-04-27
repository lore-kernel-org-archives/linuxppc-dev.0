Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFDR597HzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:36:07 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 15/16] char/genrtc: remove asm-generic/rtc.h from mips
Date: Thu, 28 Apr 2016 00:34:29 +0200
Message-Id: <1461796470-1291527-16-git-send-email-arnd@arndb.de>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/mips/sni/time.c includes asm-generic/rtc.h for no apparent reason,
and it works fine without that header, so lets remove the inclusion
in preparation of deleting the file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/sni/time.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index fb4b3520cdc6..7ee14f41fc25 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -8,7 +8,6 @@
 
 #include <asm/sni.h>
 #include <asm/time.h>
-#include <asm-generic/rtc.h>
 
 #define SNI_CLOCK_TICK_RATE	3686400
 #define SNI_COUNTER2_DIV	64
-- 
2.7.0
