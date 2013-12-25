Return-Path: <Shengzhou.Liu@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1506C2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 22:00:17 +1100 (EST)
Received: from mail157-db9 (localhost [127.0.0.1])	by
 mail157-db9-R.bigfish.com (Postfix) with ESMTP id 112FA2A0077	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 11:00:11 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/4] powerpc/fsl_pci: add versionless pci compatible
Date: Wed, 25 Dec 2013 18:06:56 +0800
Message-ID: <1387966018-10131-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are much pci compatible with version on existing platforms.
To stop putting version numbers in device tree later, we add a
generic compatible 'fsl,qoriq-pcie'.
The version number is readable directly from a register.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61d..a7c71ff 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1035,6 +1035,7 @@ static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
 	{ .compatible = "fsl,mpc8641-pcie", },
+	{ .compatible = "fsl,qoriq-pcie", },
 	{ .compatible = "fsl,qoriq-pcie-v2.1", },
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
-- 
1.8.0
