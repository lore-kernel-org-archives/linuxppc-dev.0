Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92637679F5
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Mar 2006 02:39:33 +1100 (EST)
Date: Mon, 6 Mar 2006 16:39:25 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] enable CONFIG_BLK_DEV_SL82C105
Message-ID: <20060306153925.GB2084@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Enable the onboard IDE driver for p610, p615 and p630.
They have the CD connected to this card. All other RS/6000 systems with this
controller have no connectors and dont need this option.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/configs/ppc64_defconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc5-olh/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6.16-rc5-olh/arch/powerpc/configs/ppc64_defconfig
@@ -407,7 +407,7 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
+CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
