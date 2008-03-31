Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5885DE3B7
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:59:32 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2VGxSeJ029344
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:59:29 -0500
Date: Mon, 31 Mar 2008 11:55:33 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix defconfigs so we dont set both GENRTC and RTCLIB
Message-ID: <Pine.LNX.4.64.0803311155140.4531@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new rtc subsystem conflicts with genrtc so don't enable GENRTC
if RTCLIB is enabled.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/mpc832x_mds_defconfig  |   11 +++--------
 arch/powerpc/configs/mpc834x_mds_defconfig  |   11 +++--------
 arch/powerpc/configs/mpc836x_mds_defconfig  |   11 +++--------
 arch/powerpc/configs/mpc8544_ds_defconfig   |   11 +++--------
 arch/powerpc/configs/mpc8568mds_defconfig   |   11 +++--------
 arch/powerpc/configs/mpc8572_ds_defconfig   |   11 +++--------
 arch/powerpc/configs/mpc85xx_defconfig      |   11 +++--------
 arch/powerpc/configs/mpc8641_hpcn_defconfig |   11 +++--------
 arch/powerpc/configs/prpmc2800_defconfig    |   11 +++--------
 arch/powerpc/configs/storcenter_defconfig   |   11 +++--------
 10 files changed, 30 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/mpc832x_mds_defconfig
index 79d228f..50cceda 100644
--- a/arch/powerpc/configs/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:16 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:36:51 2008
 #
 # CONFIG_PPC64 is not set

@@ -628,8 +628,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -824,10 +823,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
index 9360144..b4e82c0 100644
--- a/arch/powerpc/configs/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:20 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:36:56 2008
 #
 # CONFIG_PPC64 is not set

@@ -571,8 +571,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -767,10 +766,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/mpc836x_mds_defconfig
index 7c8b060..d50a96e 100644
--- a/arch/powerpc/configs/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:21 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:36:57 2008
 #
 # CONFIG_PPC64 is not set

@@ -626,8 +626,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -822,10 +821,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc8544_ds_defconfig b/arch/powerpc/configs/mpc8544_ds_defconfig
index c75b6ae..418bcdb 100644
--- a/arch/powerpc/configs/mpc8544_ds_defconfig
+++ b/arch/powerpc/configs/mpc8544_ds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:26 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:03 2008
 #
 # CONFIG_PPC64 is not set

@@ -742,8 +742,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
-CONFIG_GEN_RTC_X=y
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1209,10 +1208,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc8568mds_defconfig b/arch/powerpc/configs/mpc8568mds_defconfig
index e7da4b9..2b866b3 100644
--- a/arch/powerpc/configs/mpc8568mds_defconfig
+++ b/arch/powerpc/configs/mpc8568mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:28 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:05 2008
 #
 # CONFIG_PPC64 is not set

@@ -629,8 +629,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -825,10 +824,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc8572_ds_defconfig b/arch/powerpc/configs/mpc8572_ds_defconfig
index 460afe9..53aa6f3 100644
--- a/arch/powerpc/configs/mpc8572_ds_defconfig
+++ b/arch/powerpc/configs/mpc8572_ds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:29 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:06 2008
 #
 # CONFIG_PPC64 is not set

@@ -742,8 +742,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
-CONFIG_GEN_RTC_X=y
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1209,10 +1208,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 615e4c1..2075722 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:31 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:08 2008
 #
 # CONFIG_PPC64 is not set

@@ -750,8 +750,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
-CONFIG_GEN_RTC_X=y
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1217,10 +1216,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/mpc8641_hpcn_defconfig
index 994e768..d01dcdb 100644
--- a/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:34 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:11 2008
 #
 # CONFIG_PPC64 is not set

@@ -736,8 +736,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
-CONFIG_GEN_RTC_X=y
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1203,10 +1202,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index f53d55b..f912168 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:37 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:15 2008
 #
 # CONFIG_PPC64 is not set

@@ -855,8 +855,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1129,10 +1128,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 8fc8574..fdbfd39 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:41 2008
+# Linux kernel version: 2.6.25-rc7
+# Mon Mar 31 11:37:19 2008
 #
 # CONFIG_PPC64 is not set

@@ -717,8 +717,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=m
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -931,10 +930,6 @@ CONFIG_USB_STORAGE=y
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
-
-#
-# Conflicting RTC option has been selected, check GEN_RTC and RTC
-#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
-- 
1.5.4.1
