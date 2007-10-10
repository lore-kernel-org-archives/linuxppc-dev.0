Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 06F59DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:48:50 +1000 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP009FDLKKWJA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:20 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP00G9WLKJ6R70@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:48:20 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00JROLKI2XS0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:19 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:48:23 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/3] Remove empty ppc_md.setup_arch hooks.
In-reply-to: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	arnd@arndb.de, linas@austin.ibm.com, benh@kernel.crashing.org,
	geoffrey.levand@am.sony.com
Message-id: <20071010184823.13609.41058.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
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
