Return-Path: <otavio@debian.org>
Received: from aveiro.procergs.com.br (aveiro.procergs.com.br [200.198.128.42])
	by ozlabs.org (Postfix) with ESMTP id 9535C6884B
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 05:42:27 +1100 (EST)
In-Reply-To: 
Date: Sat, 3 Dec 2005 16:42:25 -0200
Message-Id: <11336353453331-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org,  akpm@osdl.org
From: Otavio Salvador <otavio@debian.org>
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH] ppc/plataforms: removed unused variable i from code.
Reply-To: Otavio Salvador <otavio@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---

 arch/ppc/platforms/chrp_setup.c |    1 -
 arch/ppc/platforms/prep_setup.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

applies-to: 8622c40782404c8fb13aa2a4dd4a7b0ebc44e896
66697dfc757179883127a3ae53bc486320b38374
diff --git a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
index f1b70ab..056ac2a 100644
--- a/arch/ppc/platforms/chrp_setup.c
+++ b/arch/ppc/platforms/chrp_setup.c
@@ -404,7 +404,6 @@ static struct irqaction xmon_irqaction =
 void __init chrp_init_IRQ(void)
 {
 	struct device_node *np;
-	int i;
 	unsigned long chrp_int_ack = 0;
 	unsigned char init_senses[NR_IRQS - NUM_8259_INTERRUPTS];
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
diff --git a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
index 4415748..f4ef267 100644
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -954,7 +954,6 @@ prep_calibrate_decr(void)
 static void __init
 prep_init_IRQ(void)
 {
-	int i;
 	unsigned int pci_viddid, pci_did;
 
 	if (OpenPIC_Addr != NULL) {
---
0.99.9k
