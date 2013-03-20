Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 902FF2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:22:34 +1100 (EST)
Received: from mail80-co9 (localhost [127.0.0.1])	by mail80-co9-R.bigfish.com
 (Postfix) with ESMTP id 7BA661200C7	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 20 Mar 2013 10:22:29 +0000 (UTC)
Received: from CO9EHSMHS004.bigfish.com (unknown [10.236.132.228])	by
 mail80-co9.bigfish.com (Postfix) with ESMTP id 606CBE04B3	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 10:22:27 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/5][RFC] powerpc/85xx: Update corenet64_smp_defconfig for
 B4_QDS
Date: Wed, 20 Mar 2013 15:52:19 +0530
Message-ID: <1363774939-29909-5-git-send-email-shaveta@freescale.com>
In-Reply-To: <1363774939-29909-1-git-send-email-shaveta@freescale.com>
References: <1363774939-29909-1-git-send-email-shaveta@freescale.com>
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
index 36a5c41..abf21ea 100644
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
