Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 332B8DDFA5
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:35:29 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ibmebus: more meaningful variable name
Date: Mon,  7 Jul 2008 18:42:09 -0400
Message-Id: <1215470529-25382-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1215469038.8970.137.camel@pasglop>
References: <1215469038.8970.137.camel@pasglop>
Cc: scottwood@freescale.com, arnd@arndb.de,
	Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Choose a more meaningful name for better System.map readability and
autopsy value etc.  Part of a cleanup suggested by Benjamin Herrenschmidt.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/ibmebus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9971159..58da8f8 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -53,7 +53,7 @@ static struct device ibmebus_bus_device = { /* fake "parent" device */
 struct bus_type ibmebus_bus_type;
 
 /* These devices will automatically be added to the bus during init */
-static struct of_device_id __initdata builtin_matches[] = {
+static struct of_device_id __initdata ibmebus_matches[] = {
 	{ .compatible = "IBM,lhca" },
 	{ .compatible = "IBM,lhea" },
 	{},
@@ -350,7 +350,7 @@ static int __init ibmebus_bus_init(void)
 		return err;
 	}
 
-	err = ibmebus_create_devices(builtin_matches);
+	err = ibmebus_create_devices(ibmebus_matches);
 	if (err) {
 		device_unregister(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
-- 
1.5.6.6.gd3e97
