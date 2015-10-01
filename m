Return-Path: <aaro.koskinen@iki.fi>
Received: from emh06.mail.saunalahti.fi (emh06.mail.saunalahti.fi
 [62.142.5.116])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DF81A1199
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 05:48:21 +1000 (AEST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] drivers/macintosh: adb: fix misleading Kconfig help text
Date: Thu,  1 Oct 2015 22:41:40 +0300
Message-Id: <1443728500-29078-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_INPUT_KEYBDEV does not exist and no additional keyboard-specific
options are needed to get the keyboard working.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 5844b80..3e8b29e 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -166,9 +166,8 @@ config INPUT_ADBHID
 	  Say Y here if you want to have ADB (Apple Desktop Bus) HID devices
 	  such as keyboards, mice, joysticks, trackpads  or graphic tablets
 	  handled by the input layer.  If you say Y here, make sure to say Y to
-	  the corresponding drivers "Keyboard support" (CONFIG_INPUT_KEYBDEV),
-	  "Mouse Support" (CONFIG_INPUT_MOUSEDEV) and "Event interface
-	  support" (CONFIG_INPUT_EVDEV) as well.
+	  the corresponding drivers "Mouse Support" (CONFIG_INPUT_MOUSEDEV) and
+	  "Event interface support" (CONFIG_INPUT_EVDEV) as well.
 
 	  If unsure, say Y.
 
-- 
2.4.0
