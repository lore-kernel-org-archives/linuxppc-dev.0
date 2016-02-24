Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28F2F1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:55:52 +1100 (AEDT)
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/powernv: Add AST graphics driver to
 powernv_defconfig
Date: Wed, 24 Feb 2016 09:55:05 +0800
Message-Id: <1456278905-4824-3-git-send-email-jk@ozlabs.org>
In-Reply-To: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
References: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most current OpenPOWER platforms have an AST BMC, so add graphics
support via the AST DRM driver.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 arch/powerpc/configs/powernv_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index ed84b2b..0450310 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -186,7 +186,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=y
 CONFIG_IPMI_POWERNV=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
-CONFIG_FB=y
+CONFIG_DRM=y
+CONFIG_DRM_AST=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
 CONFIG_FB_MATROX=y
@@ -197,7 +198,6 @@ CONFIG_FB_RADEON=y
 CONFIG_FB_IBM_GXT4500=y
 CONFIG_LCD_PLATFORM=m
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_HID_GYRATION=y
 CONFIG_HID_PANTHERLORD=y
-- 
2.5.0
