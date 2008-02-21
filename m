Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 28129DE288
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:50:22 +1100 (EST)
Date: Thu, 21 Feb 2008 22:50:21 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [USB POWERPC] ehci-fsl: add PPC_MPC837x to default y
Message-ID: <20080221195021.GC12896@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without this patch it's impossible to select ehci-fsl on PPC_MPC837x.
Another option would be to convert USB_EHCI_FSL to verbose bool,
but I presume EHCI_FSL is purposely made silent.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d97b16b..33da056 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -72,7 +72,7 @@ config USB_EHCI_FSL
 	bool
 	depends on USB_EHCI_HCD
 	select USB_EHCI_ROOT_HUB_TT
-	default y if MPC834x || PPC_MPC831x
+	default y if MPC834x || PPC_MPC831x || PPC_MPC837x
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
-- 
1.5.2.2
