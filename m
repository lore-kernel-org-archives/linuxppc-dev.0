Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B74D41A06A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:25 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 7/8] powerpc/corenet: Enable CLK_PPC_CORENET
Date: Tue, 20 Jan 2015 04:09:29 -0600
Message-ID: <1421748570-14282-8-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change-Id: I1a80ad7b9f6854791bd270b746f93a91439155a6
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 611efe9..93c38d2 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -147,6 +147,7 @@ CONFIG_STAGING=y
 CONFIG_MEMORY=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
+CONFIG_CLK_PPC_CORENET=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index be24a18..b9d75ae 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -119,6 +119,7 @@ CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_FSL_CORENET_CF=y
 CONFIG_MEMORY=y
+CONFIG_CLK_PPC_CORENET=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
-- 
2.2.2
