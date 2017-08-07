Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR7sm5PDyzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 06:09:32 +1000 (AEST)
Message-Id: <1c2ef56f08fcfcf74aa281c33363197f8c01e5ab.1502135910.git.geoff@infradead.org>
In-Reply-To: <cover.1502135910.git.geoff@infradead.org>
References: <cover.1502135910.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/3] powerpc/ps3: Refresh ps3_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 07 Aug 2017 20:09:20 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/configs/ps3_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index ee0ec5a682fc..378382683180 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -5,7 +5,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -94,7 +93,6 @@ CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
-- 
2.11.0
