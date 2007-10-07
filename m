Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 8E72BDDEFE
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 21:36:44 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 6B6FE143DA
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 13:36:42 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18650-02 for <linuxppc-dev@ozlabs.org>;
	Sun,  7 Oct 2007 13:36:41 +0200 (CEST)
Message-ID: <4708C4BE.2070303@semihalf.com>
Date: Sun, 07 Oct 2007 13:36:30 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/15] [POWERPC] Init restart/halt/power_off machine hooks
	for Motion-PRO.
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


Initialize restart/halt/power_off machine hooks in Promess
Motion-PRO board platform code.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 motionpro.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/motionpro.c b/arch/powerpc/platforms/52xx/motionpro.c
index c1bcfd2..c6954c2 100644
--- a/arch/powerpc/platforms/52xx/motionpro.c
+++ b/arch/powerpc/platforms/52xx/motionpro.c
@@ -210,4 +210,7 @@ define_machine(motionpro) {
 	.get_irq	= mpc52xx_get_irq,
 	.show_cpuinfo	= motionpro_show_cpuinfo,
 	.calibrate_decr	= generic_calibrate_decr,
+	.restart	= mpc52xx_restart,
+	.halt		= mpc52xx_halt,
+	.power_off	= mpc52xx_power_off,
 };
