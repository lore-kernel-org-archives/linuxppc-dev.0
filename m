Return-Path: <crquan@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id B2F30DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 13:16:03 +1100 (EST)
Received: by ewy9 with SMTP id 9so2134645ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 19:16:01 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 31 Mar 2009 10:16:01 +0800
Message-ID: <91b13c310903301916x1729f38dj982b185754a7c1df@mail.gmail.com>
Subject: please disable several items in 44x/canyonlands_defconfig
From: Cheng Renquan <crquan@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These 3 items are generally not used in 44x/canyonlands board, please
consider disable them when you change 44x/canyonlands_defconfig next
time,

CONFIG_PCI_LEGACY
CONFIG_DAB
CONFIG_VIDEO_OUTPUT_CONTROL

Thanks,

$ git diff HEAD -- arch/powerpc/configs/44x/canyonlands_defconfig
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig
b/arch/powerpc/configs/44x/canyonlands_defconfig
index f9a08ee..8792045 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -262,7 +262,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-CONFIG_PCI_LEGACY=y
+CONFIG_PCI_LEGACY=n
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_STUB is not set
 # CONFIG_PCCARD is not set
@@ -716,7 +716,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multimedia drivers
 #
-CONFIG_DAB=y
+CONFIG_DAB=n
 # CONFIG_USB_DABUSB is not set

 #
@@ -725,7 +725,7 @@ CONFIG_DAB=y
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_VIDEO_OUTPUT_CONTROL=n
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set

-- 
Cheng Renquan, Shenzhen, China
Casey Stengel  - "All right everyone, line up alphabetically according
to your height."
