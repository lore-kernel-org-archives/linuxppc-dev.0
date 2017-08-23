Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnQ4rnjzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 46/46] powerpc/configs/6xx: Drop removed CONFIG_USB_LED
Date: Wed, 23 Aug 2017 15:38:06 +1000
Message-Id: <1503466686-10932-47-git-send-email-mpe@ellerman.id.au>
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

In commit a335aaf3125c ("usb: misc: remove outdated USB LED driver")
CONFIG_USB_LED was removed, so drop it from our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 7a1e952b714c..da0e8d535eb8 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -960,7 +960,6 @@ CONFIG_USB_ADUTUX=m
 CONFIG_USB_SEVSEG=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_IDMOUSE=m
 CONFIG_USB_FTDI_ELAN=m
 CONFIG_USB_APPLEDISPLAY=m
-- 
2.7.4
