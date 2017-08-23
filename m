Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnK3qYRzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 34/46] powerpc/configs/mpc5200: Drop no longer needed CONFIG_FB
Date: Wed, 23 Aug 2017 15:37:54 +1000
Message-Id: <1503466686-10932-35-git-send-email-mpe@ellerman.id.au>
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

Since commit a03fdcb18632 ("drm: Add top level Kconfig option for DRM
fbdev emulation") we no longer need to set CONFIG_FB in our
defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/mpc5200_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index faa3d5789db8..7a2b2aa37def 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -70,12 +70,10 @@ CONFIG_SENSORS_LM87=m
 CONFIG_WATCHDOG=y
 CONFIG_MFD_SM501=m
 CONFIG_DRM=y
-CONFIG_FB=y
 CONFIG_FB_FOREIGN_ENDIAN=y
 CONFIG_FB_RADEON=y
 CONFIG_FB_SM501=m
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-- 
2.7.4
