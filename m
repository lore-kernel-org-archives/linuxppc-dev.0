Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 26B5FDDF1A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 23:20:03 +1000 (EST)
Date: Wed, 4 Jun 2008 15:05:20 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com,
	Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] rtc-ds1374: Rename device to just "ds1374"
Message-ID: <20080604150520.21b74355@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jean Delvare <khali@linux-fr.org>


Change the name of the device from "rtc-ds1374" to just "ds1374", to
match what all other RTC drivers do. I seem to remember that this name
was chosen to avoid possible confusion with an older ds1374 driver,
but that driver was removed 3 months ago.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
Patch already sent on:
 * 2008-04-30

 arch/powerpc/sysdev/fsl_soc.c |    2 +-
 drivers/of/of_i2c.c           |    1 -
 drivers/rtc/rtc-ds1374.c      |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.26-rc0.orig/arch/powerpc/sysdev/fsl_soc.c	2008-04-29 22:55:32.000000000 +0200
+++ linux-2.6.26-rc0/arch/powerpc/sysdev/fsl_soc.c	2008-04-30 08:32:43.000000000 +0200
@@ -432,7 +432,7 @@ static struct i2c_driver_device i2c_devi
 	{"dallas,ds1339",  "ds1339"},
 	{"dallas,ds1340",  "ds1340"},
 	{"stm,m41t00",     "m41t00"},
-	{"dallas,ds1374",  "rtc-ds1374"},
+	{"dallas,ds1374",  "ds1374"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
--- linux-2.6.26-rc0.orig/drivers/of/of_i2c.c	2008-04-29 07:41:15.000000000 +0200
+++ linux-2.6.26-rc0/drivers/of/of_i2c.c	2008-04-30 08:32:38.000000000 +0200
@@ -21,7 +21,6 @@ struct i2c_driver_device {
 };
 
 static struct i2c_driver_device i2c_devices[] = {
-	{ "dallas,ds1374", "rtc-ds1374" },
 };
 
 static int of_find_i2c_driver(struct device_node *node,
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-ds1374.c	2008-04-29 23:07:07.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-ds1374.c	2008-04-30 08:32:33.000000000 +0200
@@ -42,7 +42,7 @@
 #define DS1374_REG_TCR		0x09 /* Trickle Charge */
 
 static const struct i2c_device_id ds1374_id[] = {
-	{ "rtc-ds1374", 0 },
+	{ "ds1374", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1374_id);


--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
