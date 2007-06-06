Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8F037DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 02:57:45 +1000 (EST)
Subject: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: a.zummo@towertech.it
Content-Type: text/plain
Date: Wed, 06 Jun 2007 09:57:43 -0700
Message-Id: <1181149064.5674.134.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This fixes
drivers/rtc/Kconfig to use the correct config option.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
This is a resubmission of a patch I sent a few weeks ago.  I'm
resubmitting this as I haven't seen any activity regarding this patch
since I submitted it.

 drivers/rtc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-powerpc-8641/drivers/rtc/Kconfig
===================================================================
--- linux-2.6-powerpc-8641.orig/drivers/rtc/Kconfig
+++ linux-2.6-powerpc-8641/drivers/rtc/Kconfig
@@ -246,7 +246,7 @@ comment "Platform RTC drivers"
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
 	depends on RTC_CLASS && (X86 || ALPHA || ARM26 || ARM \
-		|| M32R || ATARI || POWERPC || MIPS)
+		|| M32R || ATARI || PPC || MIPS)
 	help
 	  Say "yes" here to get direct support for the real time clock
 	  found in every PC or ACPI-based system, and some other boards.
