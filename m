Return-Path: <bgill@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 87176685AB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 05:51:13 +1000 (EST)
Date: Mon, 24 Oct 2005 14:50:46 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: paulus@samba.org
Message-ID: <Pine.LNX.4.61.0510241447210.23727@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Fix m82xx_pci build
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc: Fix build of m82xx_pci

A recent patch updated the name of pci_assign_all_busses to
pci_assign_all_buses.  This instance of its use wasn't corrected
by the original patch to use the new name.

Builds cleanly on ads8272.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit 7910aeac19d31ad2c0f9d1a63f77e58705e46886
tree 06fbae6fee12a548a6854b2ea768b37738073d8e
parent 16e835a69ee9da54920111f99bbd6d23749ae110
author Becky Bruce <becky.bruce@freescale.com> Mon, 24 Oct 2005 14:43:39 -0500
committer Becky Bruce <becky.bruce@freescale.com> Mon, 24 Oct 2005 14:43:39 -0500

 arch/ppc/syslib/m82xx_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -306,7 +306,7 @@ void __init pq2_find_bridges(void)
 	struct pci_controller * hose;
 	int host_bridge;
 
-	pci_assign_all_busses = 1;
+	pci_assign_all_buses = 1;
 
 	hose = pcibios_alloc_controller();
 
