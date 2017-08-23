Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnP4l2szDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 44/46] powerpc/configs/c2k: Switch CONFIG_GEN_RTC from =m to =y
Date: Wed, 23 Aug 2017 15:38:04 +1000
Message-Id: <1503466686-10932-45-git-send-email-mpe@ellerman.id.au>
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

In commit 835ea93e9d26 ("char/genrtc: remove powerpc support"),
CONFIG_GEN_RTC switch from tristate to bool, update the defconfig to
match.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/c2k_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index d23507223ab4..f1552af9eecc 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -27,6 +27,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
+CONFIG_GEN_RTC=y
 CONFIG_HIGHMEM=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BINFMT_MISC=y
@@ -208,7 +209,6 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_MPSC=y
 CONFIG_SERIAL_MPSC_CONSOLE=y
 CONFIG_NVRAM=m
-CONFIG_GEN_RTC=m
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=m
-- 
2.7.4
