Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 96D4CDE159
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 01:00:10 +1100 (EST)
Date: Thu, 8 Feb 2007 15:00:08 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 10/10] ps3: ps3av/fb defconfig updates
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702081459590.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PS3: defconfig updates for ps3av and ps3fb

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/configs/ps3_defconfig |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-2.6.20/arch/powerpc/configs/ps3_defconfig
@@ -163,6 +163,7 @@ CONFIG_PS3_HTAB_SIZE=20
 CONFIG_PS3_DYNAMIC_DMA=y
 CONFIG_PS3_USE_LPAR_ADDR=y
 CONFIG_PS3_VUART=y
+CONFIG_PS3_PS3AV=y
 
 #
 # Kernel options
@@ -603,14 +604,40 @@ CONFIG_GEN_RTC=y
 # Graphics support
 #
 # CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_IBM_GXT4500 is not set
+CONFIG_FB_PS3=y
+CONFIG_FB_PS3_DEFAULT_SIZE_M=18
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
