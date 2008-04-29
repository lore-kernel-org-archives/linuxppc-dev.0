Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F312DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 20:42:58 +1000 (EST)
Date: Tue, 29 Apr 2008 12:42:41 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 0/2 v2] i2c: Add support for device alias names
Message-ID: <20080429124241.08e18ae3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laurent, Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>, Kay
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is yesterday's patch set updated to apply cleanly (and hopefully
work) on top of 2.6.25-git13. Basically the only change since yesterday
is the sync with the rtc subsystem updates, which converted 3 drivers
(rtc-x1205, rtc-pcf8563 and rtc-isl1208).

The plan is to send this to Linus this evening. The more testing it
gets, the better. Thanks to Wolfram and Jochen for yesterday's test
reports!

-- 
Jean Delvare
