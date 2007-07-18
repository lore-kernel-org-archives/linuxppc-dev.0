Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9EB02DF00A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1ZqOk019153
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:53 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZqZj001544
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:52 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BBag007950
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:11 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5FE3FAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:51 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZpR8015416
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:51 -0500
Date: Tue, 17 Jul 2007 20:35:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 39/61] mpc885ads: Whitespace cleanup (space->tab)
Message-ID: <20070718013551.GK15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/8xx/m8xx_setup.c |   72 +++++++++++++++---------------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f169355..601b389 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -89,24 +89,24 @@ init_internal_rtc(void)
 
 static int __init get_freq(char *name, unsigned long *val)
 {
-        struct device_node *cpu;
-        const unsigned int *fp;
-        int found = 0;
+	struct device_node *cpu;
+	const unsigned int *fp;
+	int found = 0;
 
-        /* The cpu node should have timebase and clock frequency properties */
-        cpu = of_find_node_by_type(NULL, "cpu");
+	/* The cpu node should have timebase and clock frequency properties */
+	cpu = of_find_node_by_type(NULL, "cpu");
 
-        if (cpu) {
-                fp = of_get_property(cpu, name, NULL);
-                if (fp) {
-                        found = 1;
-                        *val = *fp;
-                }
+	if (cpu) {
+		fp = of_get_property(cpu, name, NULL);
+		if (fp) {
+			found = 1;
+			*val = *fp;
+		}
 
-                of_node_put(cpu);
-        }
+		of_node_put(cpu);
+	}
 
-        return found;
+	return found;
 }
 
 /* The decrementer counts at the system (internal) clock frequency divided by
@@ -122,7 +122,7 @@ void __init mpc8xx_calibrate_decr(void)
 	sit8xx_t *sys_tmr2;
 	int irq, virq;
 
-        clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
+	clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
 
 	/* Unlock the SCCR. */
 	out_be32(&clk_r1->cark_sccrk, ~KAPWR_KEY);
@@ -130,24 +130,24 @@ void __init mpc8xx_calibrate_decr(void)
 	immr_unmap(clk_r1);
 
 	/* Force all 8xx processors to use divide by 16 processor clock. */
-        clk_r2 = (car8xx_t *) immr_map(im_clkrst);
+	clk_r2 = (car8xx_t *) immr_map(im_clkrst);
 	setbits32(&clk_r2->car_sccr, 0x02000000);
 	immr_unmap(clk_r2);
 
 	/* Processor frequency is MHz.
 	 */
-        ppc_tb_freq = 50000000;
-        if (!get_freq("bus-frequency", &ppc_tb_freq)) {
-                printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-                                "(not found)\n");
-        }
-        ppc_tb_freq /= 16;
-        ppc_proc_freq = 50000000;
-        if (!get_freq("clock-frequency", &ppc_proc_freq))
-                printk(KERN_ERR "WARNING: Estimating processor frequency"
-                                "(not found)\n");
-
-        printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
+	ppc_tb_freq = 50000000;
+	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+		                "(not found)\n");
+	}
+	ppc_tb_freq /= 16;
+	ppc_proc_freq = 50000000;
+	if (!get_freq("clock-frequency", &ppc_proc_freq))
+		printk(KERN_ERR "WARNING: Estimating processor frequency"
+		                "(not found)\n");
+
+	printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
 
 	/* Perform some more timer/timebase initialization.  This used
 	 * to be done elsewhere, but other changes caused it to get
@@ -164,7 +164,7 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we guarantee the registers are locked, then we unlock them
 	 * for our use.
 	 */
-        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
 	out_be32(&sys_tmr1->sitk_tbscrk, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_rtcsck, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_tbk, ~KAPWR_KEY);
@@ -180,8 +180,8 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-        cpu = of_find_node_by_type(NULL, "cpu");
-        virq= irq_of_parse_and_map(cpu, 0);
+	cpu = of_find_node_by_type(NULL, "cpu");
+	virq= irq_of_parse_and_map(cpu, 0);
 	irq = irq_map[virq].hwirq;
 
 	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
@@ -211,10 +211,10 @@ int mpc8xx_set_rtc_time(struct rtc_time *tm)
 	sit8xx_t *sys_tmr2;
 	int time;
 
-        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
 	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
 	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-                      tm->tm_hour, tm->tm_min, tm->tm_sec);
+	              tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	out_be32(&sys_tmr1->sitk_rtck, KAPWR_KEY);
 	out_be32(&sys_tmr2->sit_rtc, time);
@@ -233,8 +233,8 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 	/* Get time from the RTC. */
 	data = in_be32(&sys_tmr->sit_rtc);
 	to_tm(data, tm);
-        tm->tm_year -= 1900;
-        tm->tm_mon -= 1;
+	tm->tm_year -= 1900;
+	tm->tm_mon -= 1;
 	immr_unmap(sys_tmr);
 	return;
 }
@@ -298,7 +298,7 @@ void __init m8xx_pic_init(void)
 	int irq;
 
 	if (mpc8xx_pic_init()) {
-                printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
+		printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
 		return;
 	}
 
-- 
1.5.0.3
