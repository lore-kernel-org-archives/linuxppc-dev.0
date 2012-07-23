Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0831A2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:11 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>, Ben Dooks <ben-linux@fluff.org>,
 Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 23/25] i2c/mpc: make data used as *of_device_id.data const
Date: Mon, 23 Jul 2012 11:13:28 +0200
Message-Id: <1343034810-3386-24-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 775062c..57f7703 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -730,24 +730,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
-static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
 	.setup = mpc_i2c_setup_512x,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
 	.setup = mpc_i2c_setup_52xx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
-- 
1.7.10.4
