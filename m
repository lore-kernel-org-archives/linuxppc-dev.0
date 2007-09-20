Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 7D807DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 20:43:16 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so411516uge
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 03:43:14 -0700 (PDT)
Message-Id: <20070920104313.075667929@sunsite.dk>
References: <20070920104211.896143373@sunsite.dk>
Date: Thu, 20 Sep 2007 12:42:13 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@ozlabs.org,
 galak@kernel.crashing.org
Subject: [patch 2/3] fsl_soc: rtc-ds1307 support
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: "G. Liakhovetski" <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for the I2C devices handled by the rtc-ds1307 driver to
of_register_i2c_devices.

Cc: G. Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/sysdev/fsl_soc.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux.orig/arch/powerpc/sysdev/fsl_soc.c
+++ linux/arch/powerpc/sysdev/fsl_soc.c
@@ -319,6 +319,12 @@
 	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
 	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
 	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
+	{"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
+	{"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
+	{"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
+	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
+	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
+	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_info *info)

-- 
Bye, Peter Korsgaard
