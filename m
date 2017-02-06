Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGsXy3pHTzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:55:46 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH 1/2] powerpc/powernv: Add XHCI and USB storage to defconfig
Date: Mon,  6 Feb 2017 13:55:43 +1100
Message-Id: <20170206025544.3292-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are common on bare metal machines, so put them in the defconfig.

This adds 216KB to the vmlinux size

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/powernv_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index b793550fac..7028dbc753 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -214,10 +214,11 @@ CONFIG_HID_SUNPLUS=y
 CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_MON=m
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_STORAGE=m
+CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_POWERNV=m
-- 
2.9.3
