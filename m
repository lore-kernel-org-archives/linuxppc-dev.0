Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn86Cr8zDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/46] powerpc/configs: Drop no longer needed
 CONFIG_DEVPTS_MULTIPLE_INSTANCES
Date: Wed, 23 Aug 2017 15:37:36 +1000
Message-Id: <1503466686-10932-17-git-send-email-mpe@ellerman.id.au>
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

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") we no longer need to set
CONFIG_DEVPTS_MULTIPLE_INSTANCES in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/powernv_defconfig | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index d4ee4abf461d..2c8c4011f38a 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -185,7 +185,6 @@ CONFIG_PPP_SYNC_TTY=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 47dcef819697..8ea2db865fa7 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -185,7 +185,6 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
-- 
2.7.4
