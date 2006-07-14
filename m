Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7E66F67B67
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 21:57:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k6EBvuam018591
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 04:57:56 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6EBvsYY027916
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 06:57:55 -0500 (CDT)
Message-ID: <44B786D6.7040707@freescale.com>
Date: Fri, 14 Jul 2006 19:58:14 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: gregkh@suse.de
Subject: [PATCH] Fix Freescale high-speed USB host dependency
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The high-speed USB SOC only exists on MPC834x family not MPC83xx family.

Signed-off-by: Li Yang <leoli@freescale.com>

---

 drivers/usb/host/ehci-hcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c index 79f2d8b..3af1844 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -892,7 +892,7 @@ #include "ehci-pci.c"
 #define	EHCI_BUS_GLUED
 #endif
 
-#ifdef CONFIG_PPC_83xx
+#ifdef CONFIG_MPC834x
 #include "ehci-fsl.c"
 #define	EHCI_BUS_GLUED
 #endif
