Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id B10BCDDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 16:31:11 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l2F5V4Fi029784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 14:31:04 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l2F5Ux57019842
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 14:30:59 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l2F5UxJi001047
	for linuxppc-dev@ozlabs.org; Thu, 15 Mar 2007 14:30:59 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l2F5Ux0H005570
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 14:30:59 +0900 (JST)
Message-Id: <200703150530.l2F5Uwbo024856@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 14:32:58 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH] drivers/ata/Kconfig: PATA_SCC depends on wrong platform
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PATA_SCC depends on PPC_CELLEB. (not PPC_IBM_CELL_BLADE)

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ata/Kconfig linux-2.6.21-rc3.mod/drivers/ata/Kconfig
--- linux-2.6.21-rc3/drivers/ata/Kconfig	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ata/Kconfig	2007-03-15 23:04:14.000000000 +0900
@@ -564,7 +564,7 @@ config PATA_IXP4XX_CF
 
 config PATA_SCC
 	tristate "Toshiba's Cell Reference Set IDE support"
-	depends on PCI && PPC_IBM_CELL_BLADE
+	depends on PCI && PPC_CELLEB
 	help
 	  This option enables support for the built-in IDE controller on
 	  Toshiba Cell Reference Board.
