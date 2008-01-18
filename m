Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3D72BDDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 20:37:55 +1100 (EST)
Date: Fri, 18 Jan 2008 10:38:05 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: [PATCH] add modalias info to mv643xx_eth.ko
Message-ID: <20080118093805.GA28004@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mv643xx_eth has an platform modalias file in sysfs.
But the module itself has no alias: line. Autoloading fails
without the alias info in the module.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/net/mv643xx_eth.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -2099,6 +2099,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR(	"Rabeeh Khoury, Assaf Hoffman, Matthew Dharm, Manish Lachwani"
 		" and Dale Farnsworth");
 MODULE_DESCRIPTION("Ethernet driver for Marvell MV643XX");
+MODULE_ALIAS("platform:mv643xx_eth");
 
 /*
  * The second part is the low level driver of the gigE ethernet ports.
