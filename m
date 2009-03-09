Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 4055ADDF9B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:26:28 +1100 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 3/7] parisc: rtc: Add missing module alias
Date: Mon,  9 Mar 2009 14:26:19 +0100
Message-Id: <1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linux-m68k@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make udev autoload the driver

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/rtc/rtc-parisc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-parisc.c b/drivers/rtc/rtc-parisc.c
index f4e871c..48ef5b4 100644
--- a/drivers/rtc/rtc-parisc.c
+++ b/drivers/rtc/rtc-parisc.c
@@ -81,3 +81,4 @@ module_exit(parisc_rtc_fini);
 MODULE_AUTHOR("Kyle McMartin <kyle@mcmartin.ca>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HP PA-RISC RTC driver");
+MODULE_ALIAS("platform:rtc-parisc");
-- 
1.6.0.4
