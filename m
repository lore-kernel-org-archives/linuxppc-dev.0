Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id D9DF6DDEED
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 21:35:59 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id D33BD143DA
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 13:35:57 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06715-10 for <linuxppc-dev@ozlabs.org>;
	Sun,  7 Oct 2007 13:35:56 +0200 (CEST)
Message-ID: <4708C493.2070505@semihalf.com>
Date: Sun, 07 Oct 2007 13:35:47 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/15] [POWERPC] Init restart/halt/power_off machine hooks
	for CM5200.
References: <47075FA7.3030108@semihalf.com>
In-Reply-To: <47075FA7.3030108@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Initialize restart/halt/power_off machine hooks in CM5200 board
platform code.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 cm5200.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/cm5200.c b/arch/powerpc/platforms/52xx/cm5200.c
index 9d3b1f2..9e18bfe 100644
--- a/arch/powerpc/platforms/52xx/cm5200.c
+++ b/arch/powerpc/platforms/52xx/cm5200.c
@@ -158,4 +158,7 @@ define_machine(cm5200) {
 	.get_irq	= mpc52xx_get_irq,
 	.show_cpuinfo	= cm5200_show_cpuinfo,
 	.calibrate_decr	= generic_calibrate_decr,
+	.restart	= mpc52xx_restart,
+	.halt		= mpc52xx_halt,
+	.power_off	= mpc52xx_power_off,
 };
