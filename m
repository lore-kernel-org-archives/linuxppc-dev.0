Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 01679B7C82
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:23:51 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 89DC2DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 07:23:50 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Wed,  9 Sep 2009 23:22:48 +0200
Message-Id: <1252531371-14866-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 1/4] gpio/pcf857x: copy i2c_device_id from old pcf8574-driver
Cc: linux-mips@linux-mips.org, David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@ozlabs.org, Jean Delvare <khali@linux-fr.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The deprecated pcf8574 driver is going to be removed. Make sure this
replacement-driver inherits all i2c_device_ids for a smooth transition.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/gpio/pcf857x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/pcf857x.c b/drivers/gpio/pcf857x.c
index 9525724..3f1ec1e 100644
--- a/drivers/gpio/pcf857x.c
+++ b/drivers/gpio/pcf857x.c
@@ -28,6 +28,7 @@
 
 static const struct i2c_device_id pcf857x_id[] = {
 	{ "pcf8574", 8 },
+	{ "pcf8574a", 8 },
 	{ "pca8574", 8 },
 	{ "pca9670", 8 },
 	{ "pca9672", 8 },
-- 
1.6.3.3
