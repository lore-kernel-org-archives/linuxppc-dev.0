Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 28B73DDFEC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:25:00 +1000 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPM00F4A69N2ID0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:24:59 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM00JMI69MZ010@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 16:24:59 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00ATU69MW890@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:24:58 -0600 (MDT)
Date: Mon, 08 Oct 2007 16:24:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/6] Remove empty ppc_md.setup_arch hooks.
In-reply-to: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
Message-id: <20071008222456.25840.12222.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/virtex.c  |    5 -----
 arch/powerpc/platforms/40x/walnut.c  |    5 -----
 arch/powerpc/platforms/44x/bamboo.c  |    5 -----
 arch/powerpc/platforms/44x/ebony.c   |    5 -----
 arch/powerpc/platforms/44x/sequoia.c |    5 -----
 5 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index b52aa94..14bbc32 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -36,14 +36,9 @@ static int __init virtex_probe(void)
 	return 1;
 }
 
-static void __init virtex_setup_arch(void)
-{
-}
-
 define_machine(virtex) {
 	.name			= "Xilinx Virtex",
 	.probe			= virtex_probe,
-	.setup_arch		= virtex_setup_arch,
 	.init_IRQ		= xilinx_intc_init_tree,
 	.get_irq		= xilinx_intc_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index c17fdf2..eb0c136 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -53,14 +53,9 @@ static int __init walnut_probe(void)
 	return 1;
 }
 
-static void __init walnut_setup_arch(void)
-{
-}
-
 define_machine(walnut) {
 	.name			= "Walnut",
 	.probe			= walnut_probe,
-	.setup_arch		= walnut_setup_arch,
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
index 9bc45de..470e1a3 100644
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ b/arch/powerpc/platforms/44x/bamboo.c
@@ -50,14 +50,9 @@ static int __init bamboo_probe(void)
 	return 1;
 }
 
-static void __init bamboo_setup_arch(void)
-{
-}
-
 define_machine(bamboo) {
 	.name 				= "Bamboo",
 	.probe 				= bamboo_probe,
-	.setup_arch 		= bamboo_setup_arch,
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 5a7fec8..40e18fc 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -57,14 +57,9 @@ static int __init ebony_probe(void)
 	return 1;
 }
 
-static void __init ebony_setup_arch(void)
-{
-}
-
 define_machine(ebony) {
 	.name			= "Ebony",
 	.probe			= ebony_probe,
-	.setup_arch		= ebony_setup_arch,
 	.progress		= udbg_progress,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index 7d0d9d5..30700b3 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -50,14 +50,9 @@ static int __init sequoia_probe(void)
 	return 1;
 }
 
-static void __init sequoia_setup_arch(void)
-{
-}
-
 define_machine(sequoia) {
 	.name 				= "Sequoia",
 	.probe 				= sequoia_probe,
-	.setup_arch			= sequoia_setup_arch,
 	.progress 			= udbg_progress,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
