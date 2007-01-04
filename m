Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7C354DDE03
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 04:31:49 +1100 (EST)
Date: Thu, 4 Jan 2007 18:31:55 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] update fixup_winbond_82c105 comment
Message-ID: <20070104173155.GA3517@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Note all POWER3/POWER4 systems were fixup_winbond_82c105 will run.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/pseries/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/pci.c
+++ linux-2.6/arch/powerpc/platforms/pseries/pci.c
@@ -77,7 +77,7 @@ void __init pSeries_final_fixup(void)
 
 /*
  * Assume the winbond 82c105 is the IDE controller on a
- * p610.  We should probably be more careful in case
+ * p610/p615/p630. We should probably be more careful in case
  * someone tries to plug in a similar adapter.
  */
 static void fixup_winbond_82c105(struct pci_dev* dev)
