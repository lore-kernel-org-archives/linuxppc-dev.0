Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn32zwGzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/46] powerpc/configs: Drop no longer needed CONFIG_DEVKMEM
Date: Wed, 23 Aug 2017 15:37:25 +1000
Message-Id: <1503466686-10932-6-git-send-email-mpe@ellerman.id.au>
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

Since commit e334cd69fa65 ("Move CONFIG_DEVKMEM default to n") we no
longer need to set CONFIG_DEVKMEM in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/40x/klondike_defconfig     | 1 -
 arch/powerpc/configs/83xx/kmeter1_defconfig     | 1 -
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig | 1 -
 arch/powerpc/configs/gamecube_defconfig         | 1 -
 arch/powerpc/configs/mpc512x_defconfig          | 1 -
 arch/powerpc/configs/ppc6xx_defconfig           | 1 -
 arch/powerpc/configs/wii_defconfig              | 1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/configs/40x/klondike_defconfig
index 28adb782ec51..caab658d1da1 100644
--- a/arch/powerpc/configs/40x/klondike_defconfig
+++ b/arch/powerpc/configs/40x/klondike_defconfig
@@ -26,7 +26,6 @@ CONFIG_SCSI_SAS_ATTRS=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
index 9547dcdd6489..d21b5cb365f2 100644
--- a/arch/powerpc/configs/83xx/kmeter1_defconfig
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -55,7 +55,6 @@ CONFIG_HDLC=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index a5986208248b..141fe30737f6 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -42,7 +42,6 @@ CONFIG_BROADCOM_PHY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_QE=y
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index c0eec4a5df4e..b877a6b660a1 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -54,7 +54,6 @@ CONFIG_INPUT_JOYSTICK=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_LEGACY_PTY_COUNT=64
-# CONFIG_DEVKMEM is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index dbb61ded3849..731c5ab16d47 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -79,7 +79,6 @@ CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_MPC52xx=y
 CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index c55b7016326c..5d8fa80d7add 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -645,7 +645,6 @@ CONFIG_SYNCLINKMP=m
 CONFIG_SYNCLINK_GT=m
 CONFIG_NOZOMI=m
 CONFIG_N_HDLC=m
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_CS=m
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 600e71c1125b..aef41b17a8bc 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -65,7 +65,6 @@ CONFIG_INPUT_UINPUT=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_LEGACY_PTY_COUNT=64
-# CONFIG_DEVKMEM is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
 CONFIG_I2C=y
-- 
2.7.4
