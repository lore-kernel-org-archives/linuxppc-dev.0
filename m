Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 39E3CDE329
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:20:44 +1100 (EST)
Message-ID: <45BFD2C5.9070505@am.sony.com>
Date: Tue, 30 Jan 2007 15:20:37 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] PS3: Enable USB mass storage
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig to enable USB mass storage and VFAT.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/configs/ps3_defconfig |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-dev/arch/powerpc/configs/ps3_defconfig
@@ -677,7 +677,17 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
-# CONFIG_USB_STORAGE is not set
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -852,8 +862,11 @@ CONFIG_UDF_NLS=y
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -921,7 +934,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -945,7 +958,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
