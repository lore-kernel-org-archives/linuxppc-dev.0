Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by lists.ozlabs.org (Postfix) with ESMTP id 442B31A0E80
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 20:55:56 +1000 (AEST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by wilson.telenet-ops.be (Postfix) with ESMTP id EC9BB3585A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 12:55:53 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] powerpc/85xx: Replace CONFIG_USB_ISP1760_HCD by
 CONFIG_USB_ISP1760
Date: Tue, 26 May 2015 12:55:51 +0200
Message-Id: <1432637751-8630-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 100832abf065bc18 ("usb: isp1760: Make HCD support
optional"), CONFIG_USB_ISP1760_HCD is automatically selected when
needed.  Enabling that option in the defconfig is now a no-op, and no
longer enables ISP1760 HCD support.

Re-enable the ISP1760 driver in the defconfig by enabling
USB_ISP1760_HOST_ROLE instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 34f3ea1729e0b052..858b539d004bbfd2 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -108,7 +108,7 @@ CONFIG_SENSORS_LM90=y
 CONFIG_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
-CONFIG_USB_ISP1760_HCD=y
+CONFIG_USB_ISP1760=y
 CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.9.1
