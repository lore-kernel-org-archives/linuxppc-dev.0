Return-Path: <Zhiqiang.Hou@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0065.outbound.protection.outlook.com [65.55.169.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg1zR5nVQzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 20:24:03 +1000 (AEST)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <scottwood@freescale.com>
CC: <Mingkai.Hu@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] powerpc/config: Disable the 4KiB erase granularity of SPI
 flash
Date: Wed, 6 Apr 2016 18:14:36 +0800
Message-ID: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disable the subsector (4KiB) erase granularity to speed up the erase
operation.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/powerpc/configs/85xx-hw.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index 528ff0e..a0f4e70 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -77,6 +77,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_NETDEVICES=y
 CONFIG_NVRAM=y
 CONFIG_PATA_ALI=y
-- 
2.1.0.27.g96db324
