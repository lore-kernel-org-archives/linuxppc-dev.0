Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 939A7DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 13:58:54 +1000 (EST)
Date: Wed, 12 Sep 2007 13:58:54 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Whitespace changes to define_machine(mpc885_ads).
Message-ID: <20070912035854.GH9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the define_machine() block for mpc885_ads more greppable and consistent
with other examples in tree.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/platforms/8xx/mpc885ads_setup.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: working/arch/powerpc/platforms/8xx/mpc885ads_setup.c
===================================================================
--- working.orig/arch/powerpc/platforms/8xx/mpc885ads_setup.c	2007-09-10 16:56:54.000000000 +1000
+++ working/arch/powerpc/platforms/8xx/mpc885ads_setup.c	2007-09-12 13:53:17.000000000 +1000
@@ -441,9 +441,14 @@ static int __init mpc885ads_probe(void)
 
 define_machine(mpc885_ads)
 {
-.name = "MPC885 ADS",.probe = mpc885ads_probe,.setup_arch =
-	    mpc885ads_setup_arch,.init_IRQ =
-	    m8xx_pic_init,.show_cpuinfo = mpc8xx_show_cpuinfo,.get_irq =
-	    mpc8xx_get_irq,.restart = mpc8xx_restart,.calibrate_decr =
-	    mpc8xx_calibrate_decr,.set_rtc_time =
-	    mpc8xx_set_rtc_time,.get_rtc_time = mpc8xx_get_rtc_time,};
+	.name            = "MPC885 ADS",
+	.probe           = mpc885ads_probe,
+	.setup_arch      = mpc885ads_setup_arch,
+	.init_IRQ        = m8xx_pic_init,
+	.show_cpuinfo    = mpc8xx_show_cpuinfo,
+	.get_irq         = mpc8xx_get_irq,
+	.restart         = mpc8xx_restart,
+	.calibrate_decr  = mpc8xx_calibrate_decr,
+	.set_rtc_time    = mpc8xx_set_rtc_time,
+	.get_rtc_time    = mpc8xx_get_rtc_time,
+};

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
