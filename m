Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-236-saturday.dmz.nerim.net
	[195.5.254.236]) by ozlabs.org (Postfix) with ESMTP id DDD5BDDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 23:48:36 +1100 (EST)
Received: from kraid.nerim.net (smtp-106-saturday.nerim.net [62.4.16.106])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 2424713F20
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 13:17:07 +0100 (CET)
Date: Sat, 17 Mar 2007 13:16:44 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH] i2c-rpx: Plan for removal
Message-Id: <20070317131644.7aa7387f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c-rpx driver is broken, it depends on i2c-algo-8xx which, as far
as I can see, has never been in the mainline kernel. If nobody
volunteers to fix this, the i2c-rpx driver will be removed from the
kernel. Deadline is set to June 2007.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.21-rc4.orig/Documentation/feature-removal-schedule.txt	2007-03-16 18:43:39.000000000 +0100
+++ linux-2.6.21-rc4/Documentation/feature-removal-schedule.txt	2007-03-17 10:36:14.000000000 +0100
@@ -316,3 +316,11 @@ Why:	the i8xx_tco watchdog driver has be
 Who:	Wim Van Sebroeck <wim@iguana.be>
 
 ---------------------------
+
+What:	i2c-rpx driver
+When:	June 2007
+Why:	Broken. It depends on i2c-algo-8xx which has never been in the
+	mainline kernel.
+Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------


-- 
Jean Delvare
