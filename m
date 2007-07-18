Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8B1FDF025
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1Zsm6027680
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:54 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Zr9T001547
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:53 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BCZv007953
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:12 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id AB0ACAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:52 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZqtB015420
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:52 -0500
Date: Tue, 17 Jul 2007 20:35:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 40/61] 8xx: Whitespace cleanup in commproc.c
Message-ID: <20070718013552.GL15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/sysdev/commproc.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..e8e79f8 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -45,10 +45,10 @@
 #define CPM_MAP_SIZE    (0x4000)
 
 static void m8xx_cpm_dpinit(void);
-static	uint	host_buffer;	/* One page of host buffer */
-static	uint	host_end;	/* end + 1 */
-cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
-cpic8xx_t	*cpic_reg;
+static uint host_buffer; /* One page of host buffer */
+static uint host_end;    /* end + 1 */
+cpm8xx_t *cpmp;          /* Pointer to comm processor space */
+cpic8xx_t *cpic_reg;
 
 static struct device_node *cpm_pic_node;
 static struct irq_host *cpm_pic_host;
@@ -115,7 +115,7 @@ static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
  * and return.  This is a no-op function so we don't need any special
  * tests in the interrupt handler.
  */
-static	irqreturn_t cpm_error_interrupt(int irq, void *dev)
+static irqreturn_t cpm_error_interrupt(int irq, void *dev)
 {
 	return IRQ_HANDLED;
 }
@@ -181,7 +181,7 @@ unsigned int cpm_pic_init(void)
 		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
 		goto end;
 	}
-	eirq= irq_of_parse_and_map(np, 0);
+	eirq = irq_of_parse_and_map(np, 0);
 	if (eirq == NO_IRQ)
 		goto end;
 
@@ -197,15 +197,15 @@ end:
 
 void cpm_reset(void)
 {
-	cpm8xx_t	*commproc;
-	sysconf8xx_t    *siu_conf;
+	cpm8xx_t *commproc;
+	sysconf8xx_t *siu_conf;
 
 	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
 
 #ifdef CONFIG_UCODE_PATCH
 	/* Perform a reset.
 	*/
-	out_be16(&commproc->cp_cpcr,  CPM_CR_RST | CPM_CR_FLG);
+	out_be16(&commproc->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
 
 	/* Wait for it.
 	*/
@@ -307,7 +307,7 @@ static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
-static u8* dpram_vbase;
+static u8 *dpram_vbase;
 static uint dpram_pbase;
 
 void m8xx_cpm_dpinit(void)
-- 
1.5.0.3
