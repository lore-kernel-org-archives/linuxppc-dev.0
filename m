Return-Path: <nd@bplan-gmbh.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id C9684685DC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 17:31:45 +1000 (EST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Sven Luther <sl@bplan-gmbh.de>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-RbFmcnXkIaD0zHykO6oU"
Date: Tue, 25 Oct 2005 09:31:35 +0200
Message-Id: <1130225496.3946.2.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_showsram: Added information
	message when using the SRAM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RbFmcnXkIaD0zHykO6oU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Added information message when using the SRAM in mv643xx_eth_probe()

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>


--=-RbFmcnXkIaD0zHykO6oU
Content-Disposition: attachment; filename=mv643xx_eth_showsram_2.6.14-rc5.diff
Content-Type: text/x-patch; name=mv643xx_eth_showsram_2.6.14-rc5.diff;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
--- a/drivers/net/mv643xx_eth.c	2005-10-25 09:24:57.952386000 +0200
+++ b/drivers/net/mv643xx_eth.c	2005-10-25 09:25:02.220386000 +0200
@@ -1533,6 +1533,9 @@
 	printk(KERN_NOTICE "%s: RX NAPI Enabled \n", dev->name);
 #endif
 
+	if (mp->tx_sram_size > 0)
+		printk(KERN_NOTICE "%s: Using SRAM\n", dev->name);
+
 	return 0;
 
 out:

--=-RbFmcnXkIaD0zHykO6oU--
