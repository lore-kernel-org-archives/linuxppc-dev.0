Return-Path: <b32167@nmglablinux21.freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B259CB6F89
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 14:05:33 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <akpm@linux-foundation.org>, <w.sang@pengutronix.de>,
	<cbouatmailru@gmail.com>, <a.zummo@towertech.it>,
	<benh@kernel.crashing.org>,
	<galak@gate.crashing.org>, <grant.likely@secretlab.ca>,
	<b04825@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
	<rtc-linux@googlegroups.com>, <p_gortmaker@yahoo.com>
Subject: [PATCH][v3] Add support for RTC device: pt7c4338 in rtc-ds1307.c
Date: Thu, 16 Jun 2011 09:35:17 +0530
Message-ID: <1308197117-3586-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PT7C4338 chip is being manufactured by Pericom Technology Inc.
It is a serial real-time clock which provides:
1)Low-power clock/calendar.
2)Programmable square-wave output.
It has 56 bytes of nonvolatile RAM.
Its register set is same as that of rtc device: DS1307.


Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Change for v3:
	 Incorporting Timur Tabi's comments to drop Kconfig and copyright
         changes 

 Change for v2:
	 Incorporting Andrew Morton's comments to shorten patch by using
         hunk: { "pt7c4338", ds_1307 }

 Changes :
	 This patch will supersede patch:
		"RTC driver(Linux) for PT7C4338 chip"
	 Incorporting Wolfram Sang's comments to reuse ds1307 driver.

 drivers/rtc/rtc-ds1307.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4724ba3..b2005b4 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -149,6 +149,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1340", ds_1340 },
 	{ "ds3231", ds_3231 },
 	{ "m41t00", m41t00 },
+	{ "pt7c4338", ds_1307 },
 	{ "rx8025", rx_8025 },
 	{ }
 };
-- 
1.6.5.6
