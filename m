Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnP44wWzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 43/46] powerpc/configs/6xx: Switch CONFIG_USB_EHCI_FSL to =m
Date: Wed, 23 Aug 2017 15:38:03 +1000
Message-Id: <1503466686-10932-44-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit ca07e1c1e4a6 ("drivers:usb:fsl:Make fsl ehci drv an
independent driver module"), CONFIG_USB_EHCI_FSL was switched from
built-in to modular. Update the defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 81bc64e1bb4c..39ba8a03c9ab 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -893,7 +893,7 @@ CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_FSL=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
-- 
2.7.4
