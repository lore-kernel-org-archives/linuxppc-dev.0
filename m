Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 081452C0327
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:10 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 24/25] macintosh/mediabay: make data used as
 *of_device_id.data const
Date: Mon, 23 Jul 2012 11:13:29 +0200
Message-Id: <1343034810-3386-25-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
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
 drivers/macintosh/mediabay.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 54bf584..3f8d032 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -669,7 +669,7 @@ static int media_bay_resume(struct macio_dev *mdev)
 
 /* Definitions of "ops" structures.
  */
-static struct mb_ops ohare_mb_ops = {
+static const struct mb_ops ohare_mb_ops = {
 	.name		= "Ohare",
 	.content	= ohare_mb_content,
 	.power		= ohare_mb_power,
@@ -678,7 +678,7 @@ static struct mb_ops ohare_mb_ops = {
 	.un_reset_ide	= ohare_mb_un_reset_ide,
 };
 
-static struct mb_ops heathrow_mb_ops = {
+static const struct mb_ops heathrow_mb_ops = {
 	.name		= "Heathrow",
 	.content	= heathrow_mb_content,
 	.power		= heathrow_mb_power,
@@ -687,7 +687,7 @@ static struct mb_ops heathrow_mb_ops = {
 	.un_reset_ide	= heathrow_mb_un_reset_ide,
 };
 
-static struct mb_ops keylargo_mb_ops = {
+static const struct mb_ops keylargo_mb_ops = {
 	.name		= "KeyLargo",
 	.init		= keylargo_mb_init,
 	.content	= keylargo_mb_content,
-- 
1.7.10.4
