Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id DDA0067A6C
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Mar 2005 21:51:42 +1100 (EST)
To: benh@kernel.crashing.org
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:44:48 +0100
Message-Id: <20050306104449.109111F203@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, c.lucas@ifrance.com, domen@coderock.org
Subject: [patch 3/3] drivers/macintoshisdn/*: convert to pci_register_driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/macintosh/macio_asic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/macintosh/macio_asic.c~pci_register_driver-drivers_macintosh_macio_asic drivers/macintosh/macio_asic.c
--- kj/drivers/macintosh/macio_asic.c~pci_register_driver-drivers_macintosh_macio_asic	2005-03-05 16:12:26.000000000 +0100
+++ kj-domen/drivers/macintosh/macio_asic.c	2005-03-05 16:12:26.000000000 +0100
@@ -617,7 +617,7 @@ static int __init macio_module_init (voi
 #ifdef CONFIG_PCI
 	int rc;
 
-	rc = pci_module_init(&macio_pci_driver);
+	rc = pci_register_driver(&macio_pci_driver);
 	if (rc)
 		return rc;
 #endif /* CONFIG_PCI */
_
