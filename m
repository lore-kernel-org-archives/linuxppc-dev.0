Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id C8547DE079
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 03:31:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH 1/5 v2] Tsi108_eth: add missing linking to driver data
Date: Mon, 11 Feb 2008 11:31:37 -0500
Message-ID: <1B5F013528140F45B5C671039279CA5702A9638A@NANUK.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: <jgarzik@pobox.com>, <netdev@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bug fix for tsi108_eth network driver.
This patch adds missing linking to driver data.=20
=20=20=20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-01-24
17:58:37.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
14:30:04.000000000 -0500
@@ -1629,6 +1629,7 @@ tsi108_init_one(struct platform_device *
 		goto register_fail;
 	}
=20
+	platform_set_drvdata(pdev, dev);
 	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n",
 	       dev->name, print_mac(mac, dev->dev_addr));
 #ifdef DEBUG

---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D
