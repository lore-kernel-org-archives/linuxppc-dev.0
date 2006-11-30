Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id D7CB2679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 20:53:40 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: m48t35 add missing bracket
Date: Thu, 30 Nov 2006 10:25:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200611301025.24042.m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-ppc/m48t35.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-ppc/m48t35.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-ppc/m48t35.h	2006-11-30 00:59:27.000000000 +0100
@@ -39,7 +39,7 @@
 #define M48T35_RTC_WATCHDOG_RB         0x03
 #define M48T35_RTC_WATCHDOG_BMB        0x7c
 #define M48T35_RTC_WATCHDOG_WDS        0x80
-#define M48T35_RTC_WATCHDOG_ALL        (M48T35_RTC_WATCHDOG_RB|M48T35_RTC_WATCHDOG_BMB|M48T35_RTC_W
+#define M48T35_RTC_WATCHDOG_ALL        (M48T35_RTC_WATCHDOG_RB|M48T35_RTC_WATCHDOG_BMB|M48T35_RTC_W)
 
 #define M48T35_RTC_CONTROL_WRITE       0x80
 #define M48T35_RTC_CONTROL_READ        0x40


-- 
Regards,

	Mariusz Kozlowski
