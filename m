Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13B802C0177
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 17:34:23 +1100 (EST)
Received: from mail34-co9 (localhost [127.0.0.1])	by mail34-co9-R.bigfish.com
 (Postfix) with ESMTP id F2243100093	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 06:34:18 +0000 (UTC)
Received: from CO9EHSMHS012.bigfish.com (unknown [10.236.132.231])	by
 mail34-co9.bigfish.com (Postfix) with ESMTP id E73AD4A0051	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 06:34:16 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4][v2] powerpc/85xx: Update corenet64_smp_defconfig for
 B4_QDS
Date: Fri, 5 Apr 2013 12:03:52 +0530
Message-ID: <1365143632-19362-4-git-send-email-shaveta@freescale.com>
In-Reply-To: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
References: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 1c6eb66..6c8b020 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -21,6 +21,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_B4_QDS=y
 CONFIG_P5020_DS=y
 CONFIG_P5040_DS=y
 CONFIG_T4240_QDS=y
-- 
1.7.6.GIT
