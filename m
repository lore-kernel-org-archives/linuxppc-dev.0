Return-Path: <prabhakar@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 973D02C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 17:10:04 +1100 (EST)
Received: from mail144-db9 (localhost [127.0.0.1])	by
 mail144-db9-R.bigfish.com (Postfix) with ESMTP id 1B50C2C021D	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 06:09:58 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/configs: Enbale Freescale IFC controller
Date: Fri, 17 Jan 2014 11:39:41 +0530
Message-ID: <1389938981-30858-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently IFC NAND driver is enabled in corenet32smp_defconfig. But IFC
controller is not enabled

So, Enable IFC controller in corenet32smp_defconfig.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 branch master

 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 087d437..9578cbe9 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -25,6 +25,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_CORENET_GENERIC=y
 CONFIG_HIGHMEM=y
+CONFIG_FSL_IFC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_KEXEC=y
-- 
1.7.9.5
