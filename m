Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A3AA2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:51:23 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3bfdLw2XJ3z4KK2f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:51:20 +0200 (CEST)
Received: from localhost (p4FC466D6.dip0.t-ipconnect.de [79.196.102.214])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3bfdLw1Vltzbblm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:51:20 +0200 (CEST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc512x: enable USB support in defconfig
Date: Tue, 25 Jun 2013 08:51:19 +0200
Message-Id: <1372143079-20715-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable USB EHCI, mass storage and USB gadget support.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/configs/mpc512x_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 5b8ee80..ee853a1 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -102,6 +102,13 @@ CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_FSL=y
+# CONFIG_USB_EHCI_HCD_PPC_OF is not set
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_FSL_USB2=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_RTC_DRV_MPC5121=y
-- 
1.7.11.7
