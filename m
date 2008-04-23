Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 137DADE028
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:52:16 +1000 (EST)
Date: Wed, 23 Apr 2008 12:51:34 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Jochen Friedrich <jochen@scram.de>, Paul Mackerras <paulus@samba.org>
Subject: [2.6 patch] drivers/of/of_i2c.c: add MODULE_LICENSE
Message-ID: <20080423095134.GZ28933@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After commit 585468e5d5962660867c269e26f0a4b89a599473
([POWERPC] i2c: Fix build breakage introduced by OF helpers)
drivers/of/of_i2c.c needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/of/of_i2c.c |    3 +++
 1 file changed, 3 insertions(+)

946ca8103416a313577b0b9d52d30541fe7eef85 diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6316891..715a444 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -13,6 +13,7 @@
 
 #include <linux/i2c.h>
 #include <linux/of.h>
+#include <linux/module.h>
 
 struct i2c_driver_device {
 	char    *of_device;
@@ -113,3 +114,5 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
+
+MODULE_LICENSE("GPL");
