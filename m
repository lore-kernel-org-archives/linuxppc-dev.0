Return-Path: <00moses.alexander00@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY4sm54ghzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:13:48 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id r201so12392525wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 02:13:48 -0700 (PDT)
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
 linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, bamvor.zhangjian@linaro.org,
 kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
 Alexandru Moise <00moses.alexander00@gmail.com>
Subject: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all configs
Date: Mon, 20 Jun 2016 12:12:58 +0300
Message-Id: <20160620091258.11233-1-00moses.alexander00@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As each mount of devpts is now an independent filesystem,
the DEVPTS_MULTIPLE_INSTANCES config option no longer exists.
So remove it.

Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
---
 arch/arc/configs/tb10x_defconfig            | 1 -
 arch/arm/configs/mxs_defconfig              | 1 -
 arch/mips/configs/ip27_defconfig            | 1 -
 arch/mips/configs/nlm_xlp_defconfig         | 1 -
 arch/mips/configs/nlm_xlr_defconfig         | 1 -
 arch/parisc/configs/generic-64bit_defconfig | 1 -
 arch/powerpc/configs/powernv_defconfig      | 1 -
 arch/powerpc/configs/pseries_defconfig      | 1 -
 arch/s390/configs/default_defconfig         | 1 -
 arch/s390/configs/gcov_defconfig            | 1 -
 arch/s390/configs/performance_defconfig     | 1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig   | 1 -
 arch/xtensa/configs/iss_defconfig           | 1 -
 tools/testing/selftests/mount/config        | 1 -
 14 files changed, 14 deletions(-)

diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 4c51183..be0b4fb 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -58,7 +58,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 6e0f751..65a84b4 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -77,7 +77,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_TSC2007=m
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 2b74aee..df11563 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -266,7 +266,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index b496c25..5c40b48 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -409,7 +409,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 8e99ad8..47a2756 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -347,7 +347,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index e945c08..69aa66c 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -166,7 +166,6 @@ CONFIG_INPUT_MISC=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_HP_SDC is not set
 CONFIG_SERIO_RAW=m
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_NOZOMI=m
 # CONFIG_DEVKMEM is not set
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0450310..2fd6bbe 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -176,7 +176,6 @@ CONFIG_PPP_SYNC_TTY=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 36871a4..3c325ba 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -180,7 +180,6 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/default_defconfig
index d5ec71b..501e93a 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -453,7 +453,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defconfig
index f46a351..bd34600 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -447,7 +447,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index ba0f2a5..cfb7c50 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -447,7 +447,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 9bdcf72..48df495 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -79,7 +79,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
index 44c6764..d7b905a 100644
--- a/arch/xtensa/configs/iss_defconfig
+++ b/arch/xtensa/configs/iss_defconfig
@@ -374,7 +374,6 @@ CONFIG_DEVKMEM=y
 #
 # CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_UNIX98_PTYS=y
-# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
diff --git a/tools/testing/selftests/mount/config b/tools/testing/selftests/mount/config
index b5d881e..416bd53 100644
--- a/tools/testing/selftests/mount/config
+++ b/tools/testing/selftests/mount/config
@@ -1,2 +1 @@
 CONFIG_USER_NS=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
-- 
2.8.3
