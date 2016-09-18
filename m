Return-Path: <riesebie@lxtec.de>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scRJL1tVyzDsbC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 21:15:14 +1000 (AEST)
Received: from h06.hostsharing.net (h06.hostsharing.net [83.223.95.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mailout3.hostsharing.net (Postfix) with ESMTPS id 5B40C101E9E7B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 13:08:47 +0200 (CEST)
Received: from mail.home.lxtec.de
 (HSI-KBW-46-223-54-142.hsi.kabel-badenwuerttemberg.de [46.223.54.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h06.hostsharing.net (Postfix) with ESMTPSA id 1D5AA600058B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 13:08:47 +0200 (CEST)
Received: from localhost ([127.0.0.1])
 by mail.home.lxtec.de with esmtp (Exim 4.87 2 (LXTEC))
 id 1blZxl-0005CJ-Un
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 13:08:45 +0200
Received: from mail.home.lxtec.de ([IPv6:::1])
 by localhost (baumbart.home.lxtec.de [IPv6:::1]) (amavisd-new, port 10024)
 with ESMTP id bfLaR4mwMaMz for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 18 Sep 2016 13:08:45 +0200 (CEST)
Received: from aragorn.home.lxtec.de ([192.168.200.203])
 by mail.home.lxtec.de with smtp (Exim 4.87 2 (LXTEC))
 id 1blZxl-0005CE-NT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 13:08:45 +0200
Date: Sun, 18 Sep 2016 13:08:45 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Removed dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is
 selected.
Message-ID: <20160918110845.akvr46gdpuubo2q2@aragorn.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can use the front led of powerbooks/ibooks as a disk activitiy imaginati=
on
without the deprecated IDE_GD_ATA.

Signed-off-by: Elimar Riesebieter <riesebie@lxtec.de>
---
 drivers/macintosh/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index d28690f..5d80810 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -102,7 +102,6 @@ config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
-	depends on IDE_GD_ATA
 	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_DISK
 	help
--=20
2.9.3


--=20
  "Talking much about oneself can also
   be a means to conceal oneself."
         -Friedrich Nietzsche
