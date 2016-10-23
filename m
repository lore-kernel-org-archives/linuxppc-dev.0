Return-Path: <afleming@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2GMf2QX1zDvNh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:48:46 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id u124so6186018ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 16:48:46 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 2/3] 85xx: Enable gpio power/reset driver
Date: Sun, 23 Oct 2016 18:48:38 -0500
Message-Id: <1477266519-25173-2-git-send-email-afleming@gmail.com>
In-Reply-To: <1477266519-25173-1-git-send-email-afleming@gmail.com>
References: <1477266519-25173-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These config changes build:
drivers/power/reset/gpio-poweroff.c
drivers/power/reset/gpio-restart.c

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
 arch/powerpc/configs/fsl-emb-nonhw.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index 1a61e81..cc49c95 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -44,6 +44,7 @@ CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAME_WARN=1024
 CONFIG_FTL=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_HIGH_RES_TIMERS=y
@@ -104,8 +105,13 @@ CONFIG_PACKET=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_QNX4FS_FS=m
 CONFIG_RCU_TRACE=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_ROOT_NFS=y
 CONFIG_SYSV_FS=m
 CONFIG_SYSVIPC=y
-- 
1.9.1
