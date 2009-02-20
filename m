Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 70138DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 00:08:02 +1100 (EST)
Date: Fri, 20 Feb 2009 14:09:39 +0100
From: Benjamin Krill <ben@codiert.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Add rtas rtc calls for the QPACE platform
Message-ID: <20090220130939.GA31251@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new firmware release exports further RTC calls. This
patch adds these calls to the QPACE platform setup file.

Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 arch/powerpc/platforms/cell/qpace_setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index 775cd80..c5ce02e 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -128,6 +128,8 @@ define_machine(qpace) {
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= qpace_progress,
 	.init_IRQ		= iic_init_IRQ,
-- 
1.5.4.5
